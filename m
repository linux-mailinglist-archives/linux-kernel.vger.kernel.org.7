Return-Path: <linux-kernel+bounces-845216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 714F8BC3F05
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F7D19E3064
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5712F5315;
	Wed,  8 Oct 2025 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYrCExUK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B362F49F9
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913514; cv=none; b=DlD3mPVcyRGZatkZ4AAv5N92jmojjWx+r0WpW3E9J/ozQCLyUFg4jMBXH7B94jbGgmh/ZrjkEXXOE9kiqVxQjeQChFKQwz2L5fh5oCgr4COblmHFtca7b1nyt9k6mtep1xw5EMNJOVdaMkM5h8zdQEb/AV3U6qrDn1zLb0XFs5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913514; c=relaxed/simple;
	bh=K1jLoSzEuFbqSezYfnU5tiO0InkAWReSzsHqNYir2gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzSFUN3LygC4DJYuuBzbpYDsD6jI5Sz+XJ2gwNGYym/qzgn5fUvuK2puE+eNzHLsGyr/EFgBgZo3mmha3ju5QQGzF9FOGEp7J0cbwWcUfrMBQN12EOmCWQvWQR1AtHaJoeCzf8y01DFswPgnWbBhSME+W96t45kpFHXWNrM+SoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYrCExUK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759913511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1jLoSzEuFbqSezYfnU5tiO0InkAWReSzsHqNYir2gI=;
	b=eYrCExUKHdGGGxlBZx4q7w/wUeO/Y85AbM4PMugQu72/wNnbzxxVNGJX882evbCSIiY0af
	cMYixdShgWFmr0sU6c4kFrNUKZRNpOy4scO9H5kIoa6iWvz/SMQAjzgbjRGlOwrsVyMI2+
	S/C0rh42jx4Rj8fn2pPqIPOLcSn1cRw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-Jk04xvKsNWKOtkvJl9T3Kw-1; Wed, 08 Oct 2025 04:51:50 -0400
X-MC-Unique: Jk04xvKsNWKOtkvJl9T3Kw-1
X-Mimecast-MFC-AGG-ID: Jk04xvKsNWKOtkvJl9T3Kw_1759913509
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-afe81959e5cso1033679066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759913509; x=1760518309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1jLoSzEuFbqSezYfnU5tiO0InkAWReSzsHqNYir2gI=;
        b=puC/g/hPEgqTEkrXtAqero7jKD71Qzx1w+BcNzp4M3XD5pNqiWom2nvx0onjQ6E6ZX
         eOejHTyGVJZRtUJhQZUMABqYYoORzHDa/mJqhy5RqiR5uscYcxUDTvDrN/IlqDxDMge+
         eUOarzyym5QYU63dUEkK74y9ySR9citnuXKb3Sq+9BhtP4jo3dcUTyG4eu779TFt853Y
         t2f3PezLW2Pwiyq11UYJi84Z+mRZStU0OkNDMbeiV+io4koVtVpgDCqVzZxKVMB7mvLh
         3HWXYxkJE4PpaKy+2tTr64XkF2bJCw5K3eN9J52fx/90Dz+yTRs9dbh6knEJppkc2h8u
         K3sg==
X-Forwarded-Encrypted: i=1; AJvYcCWOiWqpsJBcfVrD7LzU9R7R/6XbbBDO/jd6gR4LfucQT5l7ul8udF2SCbCG8Cukbq2X4ma14ehYbAJvIJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1gf9fLudCNwkWDqFG8UWjeJiZwlPUA+JpSrTSiainIzil4ULn
	kS8FPOLN7CwqaC6cLJ08SOq2PT+8sQrjBTD1KqrwrZ9FhXc+CuOObJSaC6qRjVrKLu4zEfM76x3
	VZrSwOaa0042RElY4GWKrqWwuR3JX5AjSgHL7ldi3lRXFBdob+4XOx7F7HdUSzFHRPAMeFj/yrC
	Dp/8R9MaeyaK/8yR9VmcmX8rtqGiLUjoQIhJ7z7Bqk
X-Gm-Gg: ASbGncvzMWuceUTR0mBARoJczc1cfZ2oXSgLq8u/UWjXCKhYHNQm3yUpejes4Oue52/
	7Hu//Ui1/vq5igKzOWUklSkXKqAJh49EZbYrvT86c8rGbdbl3JrkeKSOjtFXrtA+F9aaV/WanB/
	5lHvmJO3lekqv32xQn/ga71a1BGbWo/S4S6QCp7EnGKl61hmejyKEwknGU
X-Received: by 2002:a17:907:6ea9:b0:b0b:f228:25a with SMTP id a640c23a62f3a-b50ac8e5713mr267299066b.64.1759913509023;
        Wed, 08 Oct 2025 01:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlLGykibVDcNGYWtPcRHTDtWzH2pHaHbQcQI7lpz4Me5SQM9O1QhytKqyATgl/LGApHGlZOh3ARmF0O5i6ufo=
X-Received: by 2002:a17:907:6ea9:b0:b0b:f228:25a with SMTP id
 a640c23a62f3a-b50ac8e5713mr267297266b.64.1759913508644; Wed, 08 Oct 2025
 01:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aOUMyGvkibvOV0IS@archie.me> <20251007185508.40908-1-krishnagopi487@gmail.com>
 <20251007185508.40908-2-krishnagopi487@gmail.com>
In-Reply-To: <20251007185508.40908-2-krishnagopi487@gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 8 Oct 2025 10:51:37 +0200
X-Gm-Features: AS18NWAa5UqMYPtJx16YwJk94Bme1M1kIPV6ZVpINM7KtV6NNimChhhnPaGzQko
Message-ID: <CAP4=nvTjauRawBPTnGEztZpdDSNhGpgSJtjoTFuq+cCQHP5oEg@mail.gmail.com>
Subject: Re: [PATCH 1/8] Documentation/rtla: rename common_appendix.rst
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: rostedt@goodmis.org, corbet@lwn.net, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com, 
	costa.shul@redhat.com, jkacur@redhat.com, 
	Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 7. 10. 2025 v 20:55 odes=C3=ADlatel Gopi Krishna Menon
<krishnagopi487@gmail.com> napsal:
>
> common_appendix.rst is intended to be included by other rtla documents
> and is not meant to be built as a standalone document.
>
> Rename common_appendix.rst to common_appendix.txt to maintain
> consistency with other common_*.txt files and prevent Sphinx from
> building it as a standalone document. Update all include references
> accordingly.
>
> Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---

Thanks for the patches! I completely missed that the refactoring of
the docs broke Sphinx, I only tested RTLA's man page generation when
doing the review...

Could you squash the changes into one patch? See the kernel documentation [=
1]:

"... On the other hand, if you make a single change to numerous files,
group those changes into a single patch. Thus a single logical change
is contained within a single patch."

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
separate-your-changes

Thanks,

Tomas


