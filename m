Return-Path: <linux-kernel+bounces-861336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78799BF275E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A1318C0282
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD95E28F948;
	Mon, 20 Oct 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mi7zAvOc"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0905285C88
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978049; cv=none; b=X8ZxwqBhfxdXdtQxXBxFiEZxz+mXcUE/J79kETnnYIeimBRCfE7Uo7BKY7J3j2N/FGgqhQk8veaqgkucBAHfaHce5XsWaZLKxojeeCkbDdfTGDxJ3I0+SLO4WTKUkfx6D0plN8+kvPEQPrEemz/Wq+kRbdKAsRDTdGTJk4lXAsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978049; c=relaxed/simple;
	bh=xiWetylhX8aIUbKWVv+lOup7Ov4PSijKXTi2mzMocEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ry3g0nf7WJPgWkEXdyJU79iZIjO9DWXK0Ts46ms2ptb1d3CGSc6jA9nJ6Bk5bp9VjyHQK8WYJMRrBTGp9zookRJbzLKyrF/D7Pl0WK34Ne39rd6DzNamX7ueitvZ/vvXXp8QW7UNohW5qpDoUOnPKYn+BluF0ch5tNEa68iBmmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mi7zAvOc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3304def7909so3802891a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760978047; x=1761582847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9NLkKkG0rJ/zH6pfyu4oN0Lt2d/eZCoAWcxhtat4F1Q=;
        b=mi7zAvOcc7P+6s3xq6Quf7oq+JvRsfk5n+o0bMEeGDAN2pz8liYLIQRtqSW7IaMoiK
         B8Zo/5JQzB54huzKbwn0dpDT5QV+/i+ww5xSr2vVnqkz/U5mNDxfCdqXfqUAo/eDYbQq
         RiCYZzdTvlBvGLc7IBrVda7dRXSDfHoGpmVsqoRhPa6BnuX3EZ3roF+NSSNxYJ2gwiUM
         O7ZPyi6+CYBxCln1Vxx/Nb0oQbxv6fRtYeekoTxnn5HRgLuO9FNR0+oc1rOY5ZbI7UiS
         YJuE/ZZtm61eai7j4pqqqqIJl0ol1ewfm28jsMpW1gzICzv38GWzMcOtFKbKAlCVYiLV
         MygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760978047; x=1761582847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NLkKkG0rJ/zH6pfyu4oN0Lt2d/eZCoAWcxhtat4F1Q=;
        b=mS4n1K3UkOi7XwELvkS3BkHWTHZnlvx9wP2W7QquTB9SKZzHCEpBm9V5MtErQa5MF/
         rwQOJ4JRFKS5hKjGrcuYWpTnMjTo1GvyiO+BWWBjq8HaUDE7XugUNV1Qp4OkZQV41HG3
         QxX3UU8oMzZl699wL7fJw0iaMj196f+s3gnQ0CuO+YBMh3sPKPmWPpBFu1Ecr2WEOTKL
         gdXCC31ZCWh4MmWCoQxttDwgKQFylBCXvCFDsU8P9tDOhsv/ptV1sRbR0SuDTEvSI9gO
         PKFPJs9ltZ8VIGqIKCVE5eDCO9Zvd4rCM/wy7FsP2on58zpx6cmwUnYhJ01reQdBnnT9
         oijA==
X-Forwarded-Encrypted: i=1; AJvYcCWNOKzUs18CUxKFR2xKUjYUqPOLTHOkl3Pf/J1JnZfOm2t130rvU5czkClO4+thFZWRqKvlk9AlnJ9iKwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqBIyOLib4sq3aQivxlmuadW5AGyBqcjVrZ1RXy9RE2OLv8A9X
	tPKi17wp92EFsBGPduDtdEs6QYm+UyOyeOl9Oqm6zcQhdo8N5XjQhvvc2VxPc9V4R36nyWBMAfS
	kbPZoXQ==
X-Google-Smtp-Source: AGHT+IEJv6yeyeoTe7I8mAefhCPoGpckkYVmGUCQNqR8Nia0SCK2k2ra2USQ3kI6crqyFEHerkAOacWrfno=
X-Received: from pjzn11.prod.google.com ([2002:a17:90b:d0b:b0:33d:acf4:5aac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52d0:b0:332:1edf:a694
 with SMTP id 98e67ed59e1d1-33bcf8fbbd3mr15270833a91.31.1760978047179; Mon, 20
 Oct 2025 09:34:07 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:33:03 -0700
In-Reply-To: <20251007222356.348349-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007222356.348349-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <176097601867.439156.11041449627994730588.b4-ty@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: Define a CLASS to get+put guest_memfd
 file from a memslot
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 07 Oct 2025 15:23:56 -0700, Sean Christopherson wrote:
> Add a CLASS to handle getting and putting a guest_memfd file given a
> memslot to reduce the amount of related boilerplate, and more importantly
> to minimize the chances of forgetting to put the file (thankfully the bug
> that prompted this didn't escape initial testing).
> 
> Define a CLASS instead of using __free(fput) as _free() comes with subtle
> caveats related to FILO ordering (objects are freed in the order in which
> they are declared), and the recommended solution/workaround (declare file
> pointers exactly when they are initialized) is visually jarring relative
> to KVM's (and the kernel's) overall strict adherence to not mixing
> declarations and code.  E.g. the use in kvm_gmem_populate() would be:
> 
> [...]

Applied to kvm-x86 gmem, thanks!

[1/1] KVM: guest_memfd: Define a CLASS to get+put guest_memfd file from a memslot
      https://github.com/kvm-x86/linux/commit/0bb4d9c39b76

--
https://github.com/kvm-x86/linux/tree/next

