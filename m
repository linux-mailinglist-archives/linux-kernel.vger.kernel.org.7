Return-Path: <linux-kernel+bounces-884422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5490BC301AE
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D1ED34E45D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C36A41;
	Tue,  4 Nov 2025 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HbfhUsNx"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E777D24290D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246701; cv=none; b=KFbj03vj09yqpDtSm8kYJxJI/HW4lel4VCCjpuxAl8ksBSGTMhZSnXVXrvgE8/oQ9Tutf2LsM6CJAkMl3FF0sixFw+B4nJHtHxH+m6yqVdM0F3Un9K03XgtpurPB0Rn1I9Vf7/ayq7gB2s3tE6+DstT3NGYxDD6lawL5myqVjek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246701; c=relaxed/simple;
	bh=buj/u/JwTsK5y0POmxcq1Ius3CNuM9gtzbALUFSrW8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdlsvbrIGPTJToVDw8ryzpdcqfK2Ua1mhVODEQ1zxRaIyT/LEf1zS3UIs0G7vhLaM+VgLE9b1u8wwJbu8OxGTatEemdnlDG7CVfPNvZqYLnS3TJLNx7rG3hXDlIGax4fhp30wBXAjcUg4S6kT65w7Ctq1K4V8MfxtsY2G+hlCUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HbfhUsNx; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5942a631c2dso1737592e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762246695; x=1762851495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buj/u/JwTsK5y0POmxcq1Ius3CNuM9gtzbALUFSrW8c=;
        b=HbfhUsNx7WiPmSs50B/3UQusuoWhnbFg1ZMUimQS7BJukDSHFOx2cHxYd352dPmkWN
         NYnFMAb8Nktqb88EtycgByVZJXBrPGunT+qGggwRwx8S18+93NIh+/+IJgyItKAMELXA
         pswDEdMmwZ6Kj21fKIB6OFxDLWJ+h4BOesF75k5cglY6XSTxo83Wpbwz98IZdLILz1u/
         CWVzghb7YJSfZWg2VXZKZZ9Mzosa+3HbekaBcc0PsYASXLbr9iO3O6WrX2hN8WolemMe
         /KJWyus7iro7QE+/5hHS/+KDb7ief1vArrpX7ID7/DpFvM3qt4r3tIsfwxWbRiWiiFE3
         mIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762246695; x=1762851495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buj/u/JwTsK5y0POmxcq1Ius3CNuM9gtzbALUFSrW8c=;
        b=jvfCEzZ+me68fWE/0gEtY0VV/kqjAI4X/SgqKXCzOwLWtcc3tAzx8UhtpH4rN1mLrM
         nRQ6mfmm5XhuI6+6i+rlC6KC29qAToMPvKbyjEUQepYLaxz2H5X2KvwJIefDZ5Jy79Ey
         yaneyHodZcIm4c/Gc5mb1X3evmCGoqMYrZ8DQxhmu79puGVR6VAY0Ap/0ePzPODIRNce
         woNvI5a7AVgVu+3iaLGfgGEmublLKpazAEAzNcczZv+ODrQvhpH0xyp2Ct8G0btuYWhP
         CNY8FP7XACP19LKWKNNLiB6cQZg6Fll0Vt3YKtIRJq3yXHbGppmUM2tVPJ4niX2m+umP
         ESzQ==
X-Gm-Message-State: AOJu0Yx59fSRTOiIjcw91WcCRDljqzmC72/lfzVhWJkzjdDFOREktasl
	7R34sKQiqLhL5EM4GXZXUkKiU98CTw+VSrjZ3EJRhKPGz4puDIMNWfgxAhskkUyCiJ9UQ0olcWx
	e/p3X1R7RxbGhLtZDkFuhGgJx+z/qtonilxDF/DF2Sg==
X-Gm-Gg: ASbGncuQ0pMVWlgD5ewjXCoQVRRM/8cy/WLBOnGd+BvUumhh28pp3tiQ+LFbJ6/27Qx
	5BgCpWoD8GJow+E1vFUnXVf4ucbfBXBz5fNqJWLniX1tcLdPB/Vz+wEiOywwuymcQkZ9tixJX/k
	ikACtJJVUHaB97E4G7DD1TWcdw+LZs5Tk8EpWUS7JmfZYeb1tI0x3UWQcCQ+3iGFddOR3qyzjDm
	FWRWklZ2VclFAUcZ4WrYetsR9snzbQDWY1BmrrvOQTPp7e1i2Pdb1cwiakfR62wiVYRLUTX0Ci7
	EdV/sxZ9+YfW5j0c0A==
X-Google-Smtp-Source: AGHT+IHzS8Tb36mlQDGSAgmbKE6QuvjHT2fmPiFvH3mcNUc3pQA3uN0hwqn5NtJVSNk2qDHMPfgxHaf6Ti5/HemNdSE=
X-Received: by 2002:a05:6512:3c92:b0:58a:fa11:b7a1 with SMTP id
 2adb3069b0e04-5941d519925mr4899489e87.24.1762246695081; Tue, 04 Nov 2025
 00:58:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030154739.262582-1-marco.crivellari@suse.com> <CAJZ5v0gV_6+3WC6eLe3nGagx+NbmqsOFtDGFnBhyrU=H+_=+dQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gV_6+3WC6eLe3nGagx+NbmqsOFtDGFnBhyrU=H+_=+dQ@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 4 Nov 2025 09:58:02 +0100
X-Gm-Features: AWmQ_bluACc7VGij-_FS6w5WYAmOVq2OjWaCef_HeyFB6IM-t2ntxrOoT6rTSWI
Message-ID: <CAAofZF52vvsH8CS-Bp+q8vFoRWW5jeEsENgtMHBetZMgNinkPQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] replace old wq(s), added WQ_PERCPU to alloc_workqueue
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 6:47=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>[...]
> All applied as 6.19 material with minor tweaks in some subjects.
>
> Thanks!

Many thanks Rafael!


--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

