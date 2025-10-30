Return-Path: <linux-kernel+bounces-877638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81143C1EA39
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C153BFE54
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4600332ED6;
	Thu, 30 Oct 2025 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRX8mOEI"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81143328E5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807251; cv=none; b=mxQxrHbDU3RBfMUjch7AZvXWNO7FoZOuF+1CTcbgdR9UpnRZ/vbJjxJyv8TwqWfMbjK2BsLdxq15R4Nn3Xk06aSF2fAOO21lHxN0W41fTs/5ElCd+FcrC8btQ/B9M45YCmunyDnX/SqeT+6yfGdZesVHGf/n43+QVp7opRe5uZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807251; c=relaxed/simple;
	bh=bOV+QrUg4/M8VjF818CgnHhOQsErUwtZQoGMulKoBA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8O3gAmrVlF0JTdBFoYYtpPjItk76BqGalcqb+vB/gj1z1Gyrj4R+MCgN8H2MeA/+w5BHBCfjXz2etVCNxlMN0WeAKzEGhYzIPn+S4eKd/r2+vecy3X9+45gehtJKdDrRUGEQjaOnf7L1Uc7SqRKbvOzW55gwVHRyFNLtrKL3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRX8mOEI; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-934c9de5cacso630199241.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 23:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761807246; x=1762412046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOV+QrUg4/M8VjF818CgnHhOQsErUwtZQoGMulKoBA4=;
        b=vRX8mOEIeIm00di3Z1Ey3qR9tGe6A8Bh/DzfgeVu0mmJyJ93sZ7lNdeitzgiF0Ns30
         HyqOiSLKBXfRKweU6hshshWx7P8Y4gR0gFXGEUAm0q8Mxz28FGmpqfqrFLnbwlMzqoBO
         +KGhEQuzBT6hTTkG57qbwhkOAEH7aXDbNs4OF4JJ8pVOx2LMxoBp4wQ2LpbGA95AblET
         j11lEuNFFkDOguZOhQK6PYJakrR6pf1yA+gy5Xriza6fKFBMzTUatHMhd7y51LF/3DzH
         gCkCcYQXvHf/W15HWX1xE09rA5eDPSTKpqSNFCggCtvMOlpugXDuclMvJnsIrxdw+SjX
         K+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761807246; x=1762412046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOV+QrUg4/M8VjF818CgnHhOQsErUwtZQoGMulKoBA4=;
        b=k4vUK+If325WbCQNj043q3iezWAsCl0aEXLC3x4kaEHIaFHo0mp2l+Gt+xenN0RDXV
         gWACLK0Px14kKowFsiagat3ng8auMm9H3NusrKoiB1G+POGQJm6J6juf0nQYAOpROjxS
         XEK71avG80jBGBLZQ3PO3d6RN/HEyDRKBoQN9RnaZWz5FyNs4nh92wiCXbpDmhUEXvW5
         9SrwxtG2a6jsQjlO8bs2O615osizp4qUXJNGGWqRULdlRimb8aWEoVMaJduPnnJqEtJO
         qS9szcjGvGzPyLobO/PACluzDZ3QaD+nnlEHgLYw/PMIptygb+Znohry+rE42i5R5hpj
         pYuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeLAqQ9MTGhud4igoxwIOwvN16YgGSriA2cBbW1Fwsvig4uqou+4Qtmf1lDDOW/w+EwLl3LANHt0vAicQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQXgcUyx0YMgkaBWqGN3tB6rPMJluXNT/xeQezlavaMieNRwyw
	HLd2Wgs7SG5Rb7fA1XDaoyCJx6WUMnA5dVnx+azAvmcGrkBRAI9L756wwY8x+l+re6LumpQqfJf
	H7CxJOxngf5XIGMgfZ4q30Y67+oH00mZLIlQUbdkH
X-Gm-Gg: ASbGncui8g8hSDk8Omnhw2Ge/5XqrZuuMlw9N80WoKhPtVz1oKNy1vfuROdBNqwp/10
	lWGqD+jHcnG7H+X4nqAp68Zkdx2QWQK18go4iMCjRSE0NnjQM3Ad7QYDq7DakXqLcXVw+w/bIhd
	o/28TBIwWNeH8/C0MetgcIPEoys3bls/waOCpALeniEkHTO5SgXT+FDgGz+s+AIvhGuI5bRFMla
	QITiIoduuF1INiJOnhPcKzEmrmawU8wCeB7MRHCmJ3MSCT/HQ7l23IAoPfj97XBXr6dznxW
X-Google-Smtp-Source: AGHT+IGoW+PTkzaMNInNo2avN5NQ3tiKAWBg6oXDGivW4Vk9NXdp3KJv7AhD9IexTWDHrOE9L8PHOdhDVBDRBbY2SEQ=
X-Received: by 2002:a05:6102:2911:b0:5db:1f8b:6183 with SMTP id
 ada2fe7eead31-5dba1e33511mr605938137.7.1761807245853; Wed, 29 Oct 2025
 23:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029185458.3040228-1-blakejones@google.com> <be48760d-b705-424e-b6b7-b75205e83567@linux.ibm.com>
In-Reply-To: <be48760d-b705-424e-b6b7-b75205e83567@linux.ibm.com>
From: Blake Jones <blakejones@google.com>
Date: Wed, 29 Oct 2025 23:53:55 -0700
X-Gm-Features: AWmQ_bkrQGFs67hXlZQAXdmmF1Lgnjs8upg2cDb8kVPErhJER0Z-EDYnwi0GM84
Message-ID: <CAP_z_Ch=On+sQdLNc3g9hnRCcRoRWazTe_oN+b7tZpF_-_KPcQ@mail.gmail.com>
Subject: Re: [PATCH v4] sched: reorder some fields in struct rq
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Josh Don <joshdon@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Madadi,

On Wed, Oct 29, 2025 at 11:29=E2=80=AFPM Madadi Vineeth Reddy
<vineethr@linux.ibm.com> wrote:
> Quick question about the lock placement: Did you test Peter's suggestion =
of
> co-locating __lock with the clock fields? If so, how did it compare to ke=
eping
> them separate?

I didn't test it (and thus I didn't make the change). Measuring the
real impact of that change seems sufficiently subtle that I wouldn't
trust any microbenchmarks to tell me anything useful about it. I'd
like to get some data from a real-world deployment of the change, but
that will take some time to set up and gather data from.

Blake

