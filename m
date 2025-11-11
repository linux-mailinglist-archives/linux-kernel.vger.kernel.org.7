Return-Path: <linux-kernel+bounces-895136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD00EC4D170
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D454A2ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30BE34A3CD;
	Tue, 11 Nov 2025 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4rMP1zd"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB9348877
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856342; cv=none; b=KK8ZbOhwvELvAnE1zErR/oZB7TMQFIbzsBnDLc/kwY3gneuGQK3OqlYLhGSkyWYfnRFY0wPtQBjJJ+v2lNUqaAwI0PoW2VJZxbUyb8cBfr6qUDF5QUiN0JCcfCxlIaX0UvmEzlZH/zHVDJa8n/iVWqU71MAE+BucW6iyVMlgTHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856342; c=relaxed/simple;
	bh=sD00pU9m45ar5Ai3zpltFpzvxBL4raSGmlVVUZkRQc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9GTxIBnV3PLXgbiW+UrB2zCXTFx23PrdS1GsYRm4Au2D2BMxz7SC/AG50zWA+6lcwfAHdIZT86UdG1niuN2YzqMrUZanF/QeB9YZgtG5kZ5NV3Nd9+nXTE8kuoIfrFGAvVb9bF7NVLCklVaHRCg/qW8dE2u2JecjWIQWeyilUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c4rMP1zd; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-656eb0b1294so1232683eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762856339; x=1763461139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sD00pU9m45ar5Ai3zpltFpzvxBL4raSGmlVVUZkRQc4=;
        b=c4rMP1zd0R6QfymMZQTLwQOe4Wsw1fFq5AvCnd1LKNIRLcs2jPV4VJUrpeK33tYsrO
         S9/VK2RWJAiUsCIuEtwe6whzRAxiBUTCqBLh1FUMXpWHCCijMq+ExydGhKBBqk8QdXRg
         aWDI0C3OvfZNcKY4ot1QUlufdjXyEHPWtSvCyS/wMADYvuIoL9sWjpVNV1lTXl/y7FaX
         mT9sT1hiq/mgyk2iHrdAJreBFMIZkEKIVUDIIhTSXn+TEyvLHUw6DZQHYXMYMIAepPRH
         9UvaP+W2wEPAfxMZR2rg+Uk+xJAg1X9+SRaxOA4Zbwjeu+J3w4xVKUTif52lkqxsI4wf
         nSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762856339; x=1763461139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sD00pU9m45ar5Ai3zpltFpzvxBL4raSGmlVVUZkRQc4=;
        b=r5JkPyEGss8BZ3KqnVQvk/89JFV8idCjup+4GpIlCA8TZxrKHG8mknBSGcTV6rR/bI
         9CdUtqK5AGRt2iJP7ds9GFBeQzg7vTIBj8SNMlwOuQlJgNJN3LpAPSIbqBKIb8NTk7Jn
         W9RQetgvG1DDFYxiX3h0P2IS5JoDmTFurwjMSHbg5OqVgxWBk+alnw8df1Nt/X90YsRa
         VjPo5tfWbEUyINCxeS1t0899bHgCstBxokbH92kVAcBdoNmmEQOpC+X6rF9dlvnV2wvd
         krPIWQDBweheXZ7q9d+OlVbJb9U6xI1q70TrYwOAxxznbJntbm4P+HdSEjB5hHS69Nsz
         BBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEINhcdA21rWP/JsSOollnq9/W23dfjoJv09Jn3YmKMPqt8X2FFuX/OfpskLDWs/GlK5uRuy38i5gk8sM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNQnjxnCXUYLoBo6qMAPnv4ZYBeGOwch47kNm9PthPc7HdME4R
	vJN0mluaEM0LsPAiFmk1/yf2MVoeiiYauSp0YJP+7xXYYjy3fI6oqUxX718hsBu5hfdwBbePiK8
	6kgmlZvyYlgJNz8an8E37rITOYbwiDZJrZrpuow4iDA==
X-Gm-Gg: ASbGncv6fhIT2wsoNjme18s3usoQBqVQY2BStOkR8F5y5ak5edNhMgdACetXjMeSCEj
	PdarxLD7O6TxgPtvrqyfbGB/RJRt482zsjCi0P0CN353q0u+TaOqRoBG1v+5vo9nede3Q0yq7Xe
	MvmXSc1ldZMgSPANXBdHGQ1xxCP0G1mOStcyoo8m5qMdRybaBKxh7qGFmVrwpAuNh9hJXeK5PZg
	t/Lv8au5UYpCGTgIg1btyKJac0V4KZkNFWz3ezf+hwEgjBwrcB8+2SfudCZFBVJ04GVd8s=
X-Google-Smtp-Source: AGHT+IFKS2q0YYMWvzAONoaylj8ozlLuIkMm1yaexf13YEyXcWtqn/MOGkO+d0PlUIAQQu2z38TBPdf0/w+7VAh46B8=
X-Received: by 2002:a05:6871:660d:b0:3d4:7d3d:be84 with SMTP id
 586e51a60fabf-3e7c2865eb3mr6778775fac.23.1762856339399; Tue, 11 Nov 2025
 02:18:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-remove-pmu-syscon-compat-v1-0-f2cb7f9ade6f@linaro.org>
 <20251103-remove-pmu-syscon-compat-v1-1-f2cb7f9ade6f@linaro.org> <20251105-guillemot-of-demonic-courtesy-6127ac@kuoka>
In-Reply-To: <20251105-guillemot-of-demonic-courtesy-6127ac@kuoka>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 11 Nov 2025 10:18:47 +0000
X-Gm-Features: AWmQ_bkZo0YG0fQozggW7w_kHLivwxPGKZYOmMZ80TBXcmQKFtFsfLDWdlG11ZY
Message-ID: <CADrjBPog8u8sRsUjcgKNG87kdcF5HHx94tUXPdTrCUG-PxSXWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: samsung: exynos-pmu: remove syscon
 for google,gs101-pmu
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org, 
	kernel-team@android.com, willmcvicker@google.com, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Wed, 5 Nov 2025 at 08:55, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, Nov 03, 2025 at 08:03:10AM +0000, Peter Griffin wrote:
> > Since commit ba5095ebbc7a ("mfd: syscon: Allow syscon nodes without a
> > "syscon" compatible") it is possible to register a regmap without the
> > syscon compatible in the node.
> >
> > Update the bindings for google,gs101-pmu so that the syscon compatible is
>
> That's an ABI break...
>
> > no longer required. As it isn't really correct to claim we are compatible with
> > syscon (as a mmio regmap created by syscon will not work on gs101).
>
> ... with kind of a reason, but then the question I have: was the
> standard MMIO regmap exposed via syscon ever working for any part of
> this PMU?
>
> Original posting here:
> https://lore.kernel.org/all/20231209233106.147416-2-peter.griffin@linaro.org/
> did not change PMU driver and did not express that the syscon is broken.

With the benefit of hindsight, no, PMU write register access was never
working for any part of the PMU.

On the initial posting I didn't hit this as we were only disabling the
Watchdog on boot (which doesn't write any PMU registers). Once the
issue with accessing PMU regs became clear, I first suspected some
missing clock. Then later it became apparent we needed a SMC call and
after some initial proposals the syscon driver was enhanced with the
of_syscon_register_regmap() API in 769cb63166d9 ("mfd: syscon: Add
of_syscon_register_regmap() API"). At the time that commit was merged,
syscon driver required a "syscon" compatible, but since ba5095ebbc7a
("mfd: syscon: Allow syscon nodes without a "syscon" compatible") that
is no longer the case.

Peter.

