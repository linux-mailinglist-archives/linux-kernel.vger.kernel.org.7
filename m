Return-Path: <linux-kernel+bounces-824210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45453B8863E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADC6567560
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A74B2ECE95;
	Fri, 19 Sep 2025 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j8xdP+Fj"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B462E7162
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270140; cv=none; b=Ef5GbVu9OmsQQl2fxFL2bdurhuZC+LaLUZ0/C2gOAW9ujuRxMQWXTlq7o3Rn0bYOYICz5eGszqwcpAWmxXyi9W1MJ4eoUABjn25wtvVtDNxz5YfwR8BQVVj0gFSm+PahpetJShigMBSM5Qc9DrYEYrbuYoJCre2NUVQUABQnE8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270140; c=relaxed/simple;
	bh=Aw9SgicXg8uTvcDi68WwtMemr663jf2AYnPudfTmQBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMPyjWtffiU0gpMhPPyd8Q/Yzsw+9nQ96vOAtS0H1w2ZawKgEMx4tIf3oxfrGqBGdKZsc7Tsgo4YqBGL2LMSaIgMTcy4Tm2Ur5h6gpMp0dgBPYwPwtTxKDgY5tQ2k/O5YyU/H7XnCJ7/a0lq+dPoc7GedZhVzVV4elLeeQ2XUf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=j8xdP+Fj; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-330b4739538so91976a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758270138; x=1758874938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA229zalAfC82US2zOC74f9JOHn8lbCuhIfoOdDNZds=;
        b=j8xdP+FjC6myfUlSB7sdwfVVLStEQClCNLkgqXFOFRB9dTJSuFusbtKYFgZhMX87S9
         JF8b1veQ5X3Hs6J3Re4YotnE7fFBJQCOGR9m+LLx+FTC0Eh8IVCNX/SFRJBjuSAiziwZ
         p3rNY+0VM1XVXpHF4C/iNMzhjroNhEmP7GyFRDJHpG4TE6+pw+YnLW+ZGk6zK4faX3Y0
         JGaY6Gxa19kxxunmtZPnZ33pTtw3f29M2tWMBe1Kdos9DX2oX3iDK+BhtI2fUQc7VEyl
         kUCfUIzapcXX8gNNaM91ATgg/AsHrR6px4F6kzihG6oVDE9agD5Si8A0JPD5kqDzxbTT
         6+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758270138; x=1758874938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qA229zalAfC82US2zOC74f9JOHn8lbCuhIfoOdDNZds=;
        b=jqvd2peaWsCGQ8/Q+n8mJ6EyJb6vLHcfo11sxoDf1e3GjgDKJ3x64eT3r4n34HD2mf
         Ptw9k5iM308ul7MHUQTGOrneGFNhEE2rDerKRQG5xe8qp/ppC7MFVvCac3Bxl9R4qbp3
         KrYTV4ytOmUj8j2bHwaw585InHodZyAmCWR9gc4rx9FFs4b1sABnBchJfQQQ0RQRciyL
         k/9PLbxeSAZTA5UrwhELbQO2tE6efYtE3Uc+kiPOPAAu7mwMu8j70/bn3SXWlnU5mRKt
         +HFwLYRP/6daPlLHMCoJTrrMKJE22UuOHUI/dZE+dbRTIXTjnwCPyV2agxxdc/xZjavN
         36/g==
X-Forwarded-Encrypted: i=1; AJvYcCW4TBk7P/MepGY38vw2IYWpE9RCGu/+6ubPz/r7uPUKnkl7VqAXXNcQnVX7zW4921XwFW9J0ALZy8BXyso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwtl1TZGPg85W5Nr/rFQ/oPmWgh8MSL/mMoVl+qSz7yQUfcXRk
	pQIApgObay9lHRapXEGfzEed/MM4FTC2kI+d0e9SdMjGkyK1UPqh0nSphXPeo+5mDhZZSzkbDz/
	1tZUe2tSQfg587Q7f9x3XkCjA/sHTQee8vwr4JzvuCQ==
X-Gm-Gg: ASbGnctIx6EK7bNMJkUYOtnOQW4C5xaxCO4nqVBMk0xbCvBtv+IGXFts7S48wAqEjIg
	l+Ffzs5hc5FD3RnEsjfiuTo/vlQvOWwKy2PUA/NjXjmpYOVv1j1fHci0og6ff/oxrmI3/FGTYP/
	CwfNbYBQW5yq+aEIFilVXzbh0yBBkxwTbctgpCfB7n7Ib1x8iaCeNIfLEZMwbRDdlBHNFhQgau8
	/8nkHRR9LAV+n/4zl6xx3bm7MCgtItTAvQC7vbC5AFiGwnJiP2U
X-Google-Smtp-Source: AGHT+IHc9AWs5Zj9Vq2lAb4i6JpeGzmbWNqHiWZsrwK3aNRHtAtv4I0vOi+7LdQMJACXH26JvU5yGr9y2p46N9fxlYA=
X-Received: by 2002:a17:90b:2d85:b0:329:ca48:7090 with SMTP id
 98e67ed59e1d1-3309838e108mr3158820a91.37.1758270138410; Fri, 19 Sep 2025
 01:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902042432.78960-1-luxu.kernel@bytedance.com>
 <aLciY2putG8g2P9F@andrea> <aMoyntAydNMtcl+3@gmail.com> <aMw3504EwlnDOJI0@gmail.com>
 <CAPYmKFt=5=t_nxY4FadG0_vSgAu1tXyO15OCvo5x6QorqM+BAw@mail.gmail.com> <aM0KBwkdPFD69oui@andrea>
In-Reply-To: <aM0KBwkdPFD69oui@andrea>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Fri, 19 Sep 2025 16:22:07 +0800
X-Gm-Features: AS18NWArXT16D1shMWryTOVEhM6i5ozD0QlpBXKJKcBDG2L55VaJoxbihBeMmRQ
Message-ID: <CAPYmKFt7pDEDAb2yVyTfKCQh7iEM1VPNdq_vEMoYFDU2cavfGw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 0/4] riscv: Add Zalasr ISA extension support
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Guo Ren <guoren@kernel.org>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, ajones@ventanamicro.com, 
	brs@rivosinc.com, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

On Fri, Sep 19, 2025 at 3:45=E2=80=AFPM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> > The existing implementation of spin_unlock, when followed by
> > spin_lock, is equal to 'FENCE rw, rw' for operations before
>
> This is not true without Zacas, that is, when using LR/SC: write-to-read
> remains unordered in that case.

Yes. Thanks for your corrections.

The LR/SC here, when Zacas or Zabha is not implemented, will behaves like:

    fence rw, w
    sd
    lr.w
    sc,w
    fence r, rw

The 'fence rw, w' ensures the order of operations before itself and 'sc.w'.
The 'fence r, rw' ensures the order of operations after itself and 'lr.w'.
The operations between 'lr.w' and 'sc.w' are as few as possible and
cannot contain load or stores as is said in section 13.3 of riscv
unpriv spec:
"The dynamic code executed between the LR and SC instructions can only
contain instructions from the base ''I'' instruction set, excluding
loads, stores, backward jumps, taken backward branches, JALR, FENCE,
and SYSTEM instructions."

So in summary, though it does not provide 'fence rw, rw' semantics,
there is limited space available for the CPU to reorder.

And, still, I think calling spin_unlock immediately followed by
spin_lock on the same core is much rarer than calling spin_unlock on
one core and spin_lock on another core.

Best regards,
Xu Lu

>
>   Andrea

