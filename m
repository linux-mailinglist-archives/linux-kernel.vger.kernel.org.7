Return-Path: <linux-kernel+bounces-738427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B01AB0B82A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 22:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76F543B8460
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB6E1D619F;
	Sun, 20 Jul 2025 20:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZFVmnC3"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95C1DF96F;
	Sun, 20 Jul 2025 20:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753043898; cv=none; b=FHTGN23sGMv3nbBG/LEVj+HS6BX4UKvYmiNcMdBkNM5W7eamEDd6X8aZo+hlKkwHbErx/IcJKoIYRxwbQ99QHHpWNbMmQm3XGEKkchqrYPtlDp+2tZLu6afn2LI0MWyXeMKMQkJVAFPPkN97Ruk8xHESnIAOePmj6hnT79nDiMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753043898; c=relaxed/simple;
	bh=pzq+r9yMIm0uTkpbSqWC8pZkfh6urePDYePki9/XTlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bdrsb6S3uvmODoB3dgz/zpeOo6IF5FpxomXmF0hZKRqW101jbiwQHwX8L/BWpshoGzMW2QOV/QMJbcOtyhw0wHiDxAjG4G/gxwdW35ejfBQYnRL4i5pWpFvN3/XdBtdKg/k21BZ+yqg711axgiaTUUxI9qzo/cbbazt3ooI+dhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZFVmnC3; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-41b6561d3c6so591500b6e.2;
        Sun, 20 Jul 2025 13:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753043896; x=1753648696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzq+r9yMIm0uTkpbSqWC8pZkfh6urePDYePki9/XTlo=;
        b=GZFVmnC3wKYnl/cJkf0+N48gMBpw4jVqds8haEWFGIsaU+X+hLwh7fD0wBAwaVIOBO
         RV4e6OoDkIYCR+ymqVib4f3/EKKNVndLOzl2vOMRHFb4wWQXjn+iLKCDrolgo0Qc37Zx
         AN2tsxU/Dq7pKUnuD++yr/9fNfslWGeAxHnheP5YVnfHQ5VUrAnImFihiZopu+t+mOh2
         wUO2e/gOymc3bXlqESEqaC7n1S96wGAikO9R+me1TkhMWdFISgZr3dqNC3DdMGRBuW9m
         Xar1rv+vIH9QE0Yi711+nQMMUFCE6PGFYA3wnt3NYO501AxOF6MwyvkiRFSBZtgj8CQR
         EISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753043896; x=1753648696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzq+r9yMIm0uTkpbSqWC8pZkfh6urePDYePki9/XTlo=;
        b=nkOKdZmax2MsQ8eqO5/TH3b26mFSPwYfCdbC6JxKKAguXDucA9hrMLpNaNXSWXW3kg
         7XqdHWSI2AMfrz0tnxvOF0giWf0WF5SI1KPDCtdN+WPKSCGfAYLaOGDCQGJznTxvMNIg
         V/Yg3A/SCdUUEGOAmCKrVcArNUC0Qj6PhVYq11Le1dgMBWxR4dUwlWxWfmndV+ljD9so
         97ZDueWYD0ct2s3/+oLmbakmi3LhuVOfsRJlTLREWhyr0tSgFOowKdXZLKd7wKSM6WSb
         h5VdxpiU/XkXU9omb+J8nFBcLZB/zdtEbjYo6cfnm88GvzDTeoXFY8Yp3KF2nbBYkrgF
         4fBw==
X-Forwarded-Encrypted: i=1; AJvYcCWjXeQKte712lVz3SVYCDM5DHOqOg5uQji7piqplOSkCvKMvIeiJSRhE6t9yEFPdbiPYBtsYQbBtHpxbMHz@vger.kernel.org, AJvYcCXHfTyhciDPr1UEL1QD9AJANySJRDlPNx3nLK35HVwCmMtaRDp91Iegn04YX2/h7gcJVHMzSMcrtxBj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5t5OrNmijdR4vYPREeUZIP56UK2dSDD83vx1G8f88c5Yo/JAn
	VuF3CwAadYlqF1bXMS4xXD9y/y3IpNR3RitbQ2+Q2C7aI2hEW40xQ6v3y4VMDeZ+mPtsGE/spB4
	Gc6uQnwrTWPK9Goy3ries4McvyRULUJs=
X-Gm-Gg: ASbGnctyObtPWyj2q9wv8PLriKCr9VDVCYwvFLNaDAtoj6P21Lu9NcYnJaZ9p4PiEJJ
	tnuN7ORE2nzcj7ftpxJu2cU/BBliIU0WPY5AdTIzVjCbvjLNFVJbcihTAmeYTIn7d6XJjPxY+jE
	mrKU06g86YIV2BE6SJ0qWqyiwo/0rDbxRlhNj7MF9XJrnY1in+kEA/khR24vfMoQ4wvq5IfgK9r
	NrT6pdZ
X-Google-Smtp-Source: AGHT+IFqM5NWjeucoA8iIWZcczbHnSPghvrG/jBV6uyfAA3kNLOPfjqdTo8q+7Q/oChHK5krN/lZwLiMN7UUnVF4/1s=
X-Received: by 2002:a05:6808:3010:b0:41c:cbbc:8abe with SMTP id
 5614622812f47-41cf04d9d0amr12433440b6e.31.1753043896177; Sun, 20 Jul 2025
 13:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717072209.176807-1-peter.chen@cixtech.com> <20250717072209.176807-6-peter.chen@cixtech.com>
In-Reply-To: <20250717072209.176807-6-peter.chen@cixtech.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 20 Jul 2025 15:38:05 -0500
X-Gm-Features: Ac12FXypnws4z96JaG_5CTTaH26H_l_f9V-btMxxJmE2pbuUWr7F44HPoNjyEoI
Message-ID: <CABb+yY0toMbsRkzBO4fpR=r2KsTfT9ms=ZYQ9r=yhsB_YY88AQ@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] mailbox: add CIX mailbox driver
To: Peter Chen <peter.chen@cixtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com, maz@kernel.org, 
	sudeep.holla@arm.com, kajetan.puchalski@arm.com, eballetb@redhat.com, 
	Guomin Chen <Guomin.Chen@cixtech.com>, Gary Yang <gary.yang@cixtech.com>, 
	Lihua Liu <Lihua.Liu@cixtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 2:22=E2=80=AFAM Peter Chen <peter.chen@cixtech.com>=
 wrote:
>
> From: Guomin Chen <Guomin.Chen@cixtech.com>
>
> The CIX mailbox controller, used in the Cix SoCs, like sky1.
> facilitates message transmission between multiple processors
> within the SoC, such as the AP, PM, audio DSP, SensorHub MCU,
> and others.
>
> Reviewed-by: Peter Chen <peter.chen@cixtech.com>
> Signed-off-by: Guomin Chen <Guomin.Chen@cixtech.com>
> Signed-off-by: Gary Yang <gary.yang@cixtech.com>
> Signed-off-by: Lihua Liu <Lihua.Liu@cixtech.com>
> Signed-off-by: Peter Chen <peter.chen@cixtech.com>

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

Thanks
Jassi

