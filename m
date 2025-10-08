Return-Path: <linux-kernel+bounces-845487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D232BC5223
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F221888C88
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33B42836BE;
	Wed,  8 Oct 2025 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XUCwiSES"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494327A45C
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928910; cv=none; b=qxgWdzceps+wZ9eOZ7azGP76uRXra9rLJb0nynKdw31zvbt/vI4ZPC55lBKzL7r04F3bv22NhF2g94t2JpjmzqiWEonqdl0Flym4oD8W05S+HAoZEZpSpJ5rtUSfsWSjwa9ZfBh3j4DUBNnYXTC+mdr23xHL+WtohCo1n1Ojs9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928910; c=relaxed/simple;
	bh=hCEpujIAQjzq+71JO1DtwhcA8vBsjBZGICHvXjHGXsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8ynhor4RIXKRUwKrk0Zz/uWaLdm5K5lpw5p2vC7TttXiMpOGNMYY8YOYzECG5FguejA5t4ckY5xxLBL+4otMgkU40s0NYSFXUpi96CQuBnGYkqMKmB612gAc9wOYwxZpSB7OGvBzTnUX3727anL/qOG+rZMQzZuR8FNF0JEXpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XUCwiSES; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-373a1ab2081so61788861fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 06:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759928906; x=1760533706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCEpujIAQjzq+71JO1DtwhcA8vBsjBZGICHvXjHGXsw=;
        b=XUCwiSESE+Yotrpsv8pPW/FW3Cs9vJToe9gNGoWlCm2Dw8Pp4BkWO6Bd/DfB7qgyjG
         O4hL0SQPXWrJDNfrNTIL8GMC9zG/YT1Bqcb2pn70Tcp1kjGpkJN9gHCQ02Wc+ry0SB04
         Rfehh74eKgT1hbjQKbcmaC8upPNe8N4XAb4Asjy7PfkQ8o+y4PsyJT8H2BthVOcL4Dks
         j2FbIl1sPUqi92Zho093nNT8AiRLWP1kULtV1I3GTK35SHDJFoVoPTP9R0OQcTQH09rH
         Sd/nomktOOOeLW3UHQaHstOt4cTM29iubdPwnwyysNJu/BVRh2VSLQXh0Aq1CUVm+A4N
         9xDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759928906; x=1760533706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCEpujIAQjzq+71JO1DtwhcA8vBsjBZGICHvXjHGXsw=;
        b=bRehvbxD2qZ/lbxnX/dcTtx5SRt1Hcr3BoKQHVyV8w7UL4wseSlmPesaRmOopx2wIy
         cVfxHldorD+3Y5RZ+bBzpEUPoAiXy8DvGNpTHIEz3Y6gnc68eUs/3f1t4HKJ62FCAymW
         SnaCh2hUifSc+YYu9ahqwMfGPIvEbomeZEFBE5N2CyQgLGEjFvSTala0kuiY2zFspiXh
         JaaFF4d1H36w9NqN/Bi8i6dS+Gaw3y54jLzrVXwLFzxstMqeduAad/xGpQwGCzY5ZD7p
         LwLDIqUoDBpEotqB18eXYtwYZufWSbNsX06Usn66Twwu+ABGmusueW+/4hpPgZFpuste
         jd6w==
X-Gm-Message-State: AOJu0Yw//qYsOc+wjI+AkptExId5RMmUQ445oabSCFFdkLnvCOCRIXD/
	LTKpLXKDHzqAH50jrH5euRwrVYdPHTxN5jzkLz59KufAYrRSFmd4JZC9kGKrho+IatOa5rgr0hG
	0/7eLfyiX6YzOFpDpD1fgzGduVayRIAiqt5cbM+g3Rg==
X-Gm-Gg: ASbGnct0syZNJxTSnMLVnfgNDYa5mYnV+uQgsV3nVkKnCtvUO3R6ZuaatQ6/msI2SkW
	sGuOhRXldqgu1BsrvZTBx85O76zo0XSRBRu2OvbweO01bGF8993gEz2dvT4n30Xv8zye+gO8HHr
	JC96GN07fbEYQa6kGwdSftzLjVi8Wo+rcoGu7VOCygWTqPDXUZD8CFxi36QnQHuN+gLluNjbq5P
	yZsJP+B8sF/AP4yypK+WIKQrAEmGkwPUzX4xW1O987/2q7Kynfdbm2T5UBuHqJF
X-Google-Smtp-Source: AGHT+IFee/L1ihvsJoJN8qn9mdf5cQv75y1ErzWOfzWMnIXy8m5xgcvGSMTnVzjnBNArGE8jLQiNlkQeXTXf0/ONVM4=
X-Received: by 2002:a05:651c:1990:b0:363:d806:7d5b with SMTP id
 38308e7fff4ca-37609a1a8e8mr7197091fa.0.1759928906448; Wed, 08 Oct 2025
 06:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908160224.376634-1-marco.crivellari@suse.com>
 <20250908160224.376634-2-marco.crivellari@suse.com> <aOZgR7X5ZyXZh_jc@google.com>
In-Reply-To: <aOZgR7X5ZyXZh_jc@google.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 8 Oct 2025 15:08:15 +0200
X-Gm-Features: AS18NWCy8lu9sYT938kbcqk4cxkt4xkSfqGFbSwCDaUGQeBgodxXuFjXFCcOXyQ
Message-ID: <CAAofZF74M3jrWJNZOy3KLyVg7mS7yKzofOUQ+gmmyxYoXbqBSg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: replace use of system_unbound_wq with system_dfl_wq
To: Alice Ryhl <aliceryhl@google.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 2:59=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
> Please add documentation to the new methods, similar to the
> documentation that existing methods already have.

Sure, thanks for the feedback.

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

