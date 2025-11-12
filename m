Return-Path: <linux-kernel+bounces-897108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6822C52048
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 008C7506972
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A783101C8;
	Wed, 12 Nov 2025 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQVxioWc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcAd8N0D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF6D30FF1D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946897; cv=none; b=dql/yMQCKgvFYtNtzwOeBUBNnLNquhpmbd9XyY3FtaEk5g+CPlx6k+IvKqNrX3Sv66GWLqzK8yJPGg+DpQr/9IzKAbQnQI2yyhLnvPwjeQz6Kapsfa5Y0lesia66XN/QuJXggSfGcj9MKigbvfDmTC7NfJnYraq/00wJcc5BPFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946897; c=relaxed/simple;
	bh=w9b2RxEPIpBQFFaebpQtwOH3HfQgFg+EyEqHMhWr7p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZrFzv7IInwJKh+qeMp3PKzTJxExi6pXqn4t+NPaMSHmGXIH7EPx3Dy0IhDANHQBs3uTMno+RuwWcKiswBU5LukhXTOQKW8zDt/4ENzuk4oaoVa1mOKqvqkKUpQy9r+BX7XlCzoNsUyYpePgzUqyIEImJzAxB7ijPL8y3fBdX0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQVxioWc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcAd8N0D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762946895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXbr75syi7AqX8YAj0Uq0xwyVkaRbUdxvBGBY9PH2cY=;
	b=jQVxioWcqTqSRT9YcOr+iMl0pjlcqzaEtV4Gtrs5FzVEnclIVWc0XjK8hfXP6tqpBQBV30
	A5L9V0+4wxH1E2kEycn660zdD0UuT5n8M1Zp0RVcfMsxr0jdZlUceNkOR9kzbA/4ctke8g
	dGfO41ZS35vIJvemyWD9gCEArD9dmS4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-6s6tOPlpPyqkJjtWnk1WxA-1; Wed, 12 Nov 2025 06:28:13 -0500
X-MC-Unique: 6s6tOPlpPyqkJjtWnk1WxA-1
X-Mimecast-MFC-AGG-ID: 6s6tOPlpPyqkJjtWnk1WxA_1762946893
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8804b991a54so26732156d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762946893; x=1763551693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cXbr75syi7AqX8YAj0Uq0xwyVkaRbUdxvBGBY9PH2cY=;
        b=UcAd8N0DErhar9fdaQ1F4OZvc0G/9LAs90XoqqiIbWoJH0uZtg13duTIZvta02E2Ek
         DNkdX8YCAy/7sUjbliF4Q+YEv09aTx47g3wFEI2kbofCZZEvREnlrqXbwUybF70bcq/I
         FwhfCScCXEK6gpUfdlQgrATTnkq/yoCpaOiJ4KkIqX86YAGfc4Ktb6hf0JeU5JyPY568
         nKYiZUMrcHZY1k/b4NcrgTSEyE/NdXrDnOy5+yhTcTCXp0sXvxTWGdGRJyEtuL1i59cS
         OzMGdDgR+DJ08RZsDDl4f1/5exMr5xYUtjo6Knj1Gki/qcYtt3DnYoX7gIfRYZTIU34d
         iCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946893; x=1763551693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXbr75syi7AqX8YAj0Uq0xwyVkaRbUdxvBGBY9PH2cY=;
        b=sCE4yTUTmfrWSN9IvBNCV0/JxSUq8ps0J9zfMXIYlTPkrq8bB3Zgc72wxUx42jWPCo
         e1j/1SQYqub6hOi6S8DeNvGwQB3jcSdSjat9q6jcoBDPIt4wFn43TP1P4wVsTcv9/bOK
         oyWB4vt5UwydnjObJ5nYLWI9LokSvBm7Q2eMU9Hvgm2evEJKS8PMF/pB2vhQQVrrOh2i
         ZHTXkrsounoxygaf6JEQCOsYUVar49jbJePzChDa/Va/rffJsPKSgwTJtQTmx8mLCayM
         X8vXOW3CJwjoUUfjoy2+kXJFEQwKxCsf08An+UgNKiZEAcVzaXpTFnaiHdLVPHyMQYuC
         WO6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeQ3vcLVDi+FU9bwEM7XUHjsF22Z4kOpY7XGeEeRsd1LWFXs3Z/tS1dKatBZuODQ5i7lgnTSzTmt6skOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw83bjaueia4Bp2MHXGe2yddtUKtQP3gEU6DeGjIyXo1t2Ac1cw
	6V5wni6jrizzcrNqv8xn+kQ8Iqspg4YzjslmGBb+nBwyf4g4MxmgIonmv9uLoy1ZVm7gWI+qA7n
	csHNDBUPWo6xku6ZOFzpmDwi5RwgdZPOM0skrC67gHak7vBUmlcMvjpI26MUDERfPaQ==
X-Gm-Gg: ASbGnctBYkjSX7whl6/ovnuafmR/n5QCB8IVzgHZ7wXa9Hqkw2aDhiWDGShRnQ0yTkR
	MfxkjNBTtEQY1b9mK00gyB/0KM2ME3yLSGmmuo7H2TDqW9n2mpO5NghHwXCWmDV1XtdKAI1J15K
	Pe47U/07tvSOlPNXrjGCHSV2wuorb2LWB8+7l+dcUPMC4C5X3Sho2kJxlDkqxCgl+FKhTlTbTdX
	gfjCnPJb/DjmOKNxRG2mJAV+fVQnuK/zhNiWBUoCo+doh40h1aqhiAfN1/T9JxHg5rM8QnJc/Y7
	8gyzv9AquBiwYmooHF8qi/HWCoV5Bh9gehx5UfWRRJqS6ZsY+/62HJVtIbPW6Ik0dSJ41eUk0vr
	9D4YbMoSuFBz04WZbNwNDF449V/OSNnPylb+KgxwwjeAkelmTqts=
X-Received: by 2002:a05:6214:2248:b0:880:298b:3a6d with SMTP id 6a1803df08f44-88271a2a00emr36352996d6.35.1762946893352;
        Wed, 12 Nov 2025 03:28:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnA7ozYlvXHQMnpycDhkhnMaFa5erx7IOPg689k7NBMlvaatOo3MEwHXk4xMfYTAwAfX3oqA==
X-Received: by 2002:a05:6214:2248:b0:880:298b:3a6d with SMTP id 6a1803df08f44-88271a2a00emr36352786d6.35.1762946892999;
        Wed, 12 Nov 2025 03:28:12 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8823896a8d9sm92866156d6.17.2025.11.12.03.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 03:28:12 -0800 (PST)
Date: Wed, 12 Nov 2025 12:28:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 12/12] selftests/vsock: disable shellcheck
 SC2317 and SC2119
Message-ID: <r5uyojkue5zgoiixgmrjoew6pe6p7jzhd4hsudoxdirwummht3@fclnufaabg6g>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
 <20251108-vsock-selftests-fixes-and-improvements-v4-12-d5e8d6c87289@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-12-d5e8d6c87289@meta.com>

On Sat, Nov 08, 2025 at 08:01:03AM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Disable shellcheck rules SC2317 and SC2119. These rules are being
>triggered due to false positives. For SC2317, many `return
>"${KSFT_PASS}"` lines are reported as unreachable, even though they are
>executed during normal runs. For SC2119, the fact that
>log_guest/log_host accept either stdin or arguments triggers SC2119,
>despite being valid.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 2 ++
> 1 file changed, 2 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 42e155b45602..c7b270dd77a9 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -7,6 +7,8 @@
> #		* virtme-ng
> #		* busybox-static (used by virtme-ng)
> #		* qemu	(used by virtme-ng)
>+#
>+# shellcheck disable=SC2317,SC2119
>
> readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
> readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
>
>-- 
>2.47.3
>


