Return-Path: <linux-kernel+bounces-851220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBEDBD5CDF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C695D4E5336
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C252D8767;
	Mon, 13 Oct 2025 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgA0bG64"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA182D7DCA
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381810; cv=none; b=a6oFBDbdDn5XxoGoszIR6ksSomRe26AsB2eux07VWdn7hr5ORRURN3S/BQTfASCoOtuZ5s7gi4cGxn1dnNLOQgBZCFds/vFodVblp7Ic+Tc4vTAgMIAeGB92uz08WPdC393hog8J1ksP5gGnm4wKz31+t94IW+ZW8AzY8tWUOqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381810; c=relaxed/simple;
	bh=BPXQKYM/Bl3lXPIDhXdBBlg948y7qQGSlqXVphTncFg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l6fGktxYmsY6VdVvbhM4u9zpg3RCeDcDCfm0zgrQQnC0J/QH8m2UOJfKzL7L/MYtKp4/4oOUgheIjYBhnQ6o9haoIAkisltFtUvgH6lPl+wpZYc/MNnbyB80Rk2IBBHCx57wPIKk26+JnoZDiU+HEyfsCXbZudZ2nqBObNSB1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgA0bG64; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso3464106f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760381807; x=1760986607; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5PdPqTzdF7SvDyD8IZhblvwhbzmwKXRkjyRcByHgouQ=;
        b=KgA0bG64DZz2UQCSAcRM3i4EkJ1EMTlKPtV7tPyzmkExbl/0hEDRTdL7ru31BYV3co
         waObbuHfxYlgx4xZqJev1b9KvpCzoWwC4tPQy/UKMMUwbq1Nufk2cnwDEK8q2poEgXev
         ANHg9otFk14zLXHIulUYeuCmohoUiVl5gLgxaBj4zQmcaDGToQvzhz3eNvPlWyf0DS7j
         ZbDQNhpxSwaPo5sitdsyiRpR8wnSaiCSukLz0WOWwxn7+KBq/aEovDFXOLeYdn51JE8D
         v27ypaA+JEF2vyPF2K4hhbH6z32FVMvMW1BK5dgru9g2flflopUf5E6q3xlGCO+INV+6
         ye8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760381807; x=1760986607;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5PdPqTzdF7SvDyD8IZhblvwhbzmwKXRkjyRcByHgouQ=;
        b=K0Kkidpe71ENbUXAmHAuy7zmxiu3FovsS5mndVrr4MpfI5bbHsgzgBTc2Rb1hsCmwq
         WKOazDTEiYrbFaARh8OGIJguYq66l8ZiASzyMjB6LZWJYWambeVr7zMUBb3QUwVYg9xd
         IBAiEqhmsAnITTxvjrxlF7xj956O5yc8Cza+Bv4NwIYzW7qOuM7rKsfAT21EVD7x/F8V
         +ZNVQaOZushv1oUtIyE848iV7zSAcxJIwyf0iFf/qrdTMKS3KcDhgqlbGEJUkDxuBFk9
         zWn81QGxGEv+AXHitT3/9ld8IKcMLje/YuJ1qnSFbTA2KAwF/KVPSI/bhYrtcqa6l7t5
         1m8g==
X-Forwarded-Encrypted: i=1; AJvYcCXjMFNephCUWDZfRp3ZOax7WczasafSeYjcxX9VnYQSTdXHuz2HlxeE9zaUiZAzkeDRg8l7gnA2ehrZ9uo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw187iIM/1u1TdNHIp/HXHfE5kadgKZ8AFFiI5Q2lmNyJv/HcJ2
	iyvm8zHABj4wkous1ue/LkQLlZxY0wGOFrZWKAiHD/qxegmMAMZBUGik
X-Gm-Gg: ASbGncsn6yqBUG6KUi709tG9EU+9OQlN6nVsOsjq0U+jD9aQL+H7oEzCJTTRb4u9dmc
	sJSz7ded8RNyzKjwGlwljBIhLXx+AHWGHwp+1V2aJ0W0qtq3edtr5GX41cDmZJcEIkokHo+Q4YO
	Ha2yx+k1m3kWEzvwNqvR98ZpiCxAVBub7nQkEXgCDEglemH7Xt6OFIt7BT0aprvKu+GrIPqFD0k
	uEspmUTyRV8JnPNSPc5qFnio+aUAx6o9Gs4uKnIz9yVmlTDBgvDPsn+YrjgF69Akb7zcPHXzHMS
	3jst93gckVnXUmSiO/1N+Kr7PA+Ltg32eFpNOtCdOznoG+9AvxMAaFN/8veBuQE5P17RlOSP+5f
	q90sO6TuqZlkrhHIjGPSPVXFiUGBec6BMQTSZdNkN5RWO6w81ev24PW+l6c3MNkU96Poj5TBEeT
	5K9ZwOu7ca26M=
X-Google-Smtp-Source: AGHT+IHai3Mls23wDtQjYqU+yA8Bnt/Z79B4F1zs18pyxM/Jfa95xJJVJk8x/0DLk0Rp7CvMuxbr5w==
X-Received: by 2002:a05:6000:1845:b0:3e7:6104:35a8 with SMTP id ffacd0b85a97d-4266e7dffccmr14069380f8f.35.1760381806685;
        Mon, 13 Oct 2025 11:56:46 -0700 (PDT)
Received: from localhost (dhcp-91-156.inf.ed.ac.uk. [129.215.91.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426e50ef821sm4879612f8f.38.2025.10.13.11.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:56:46 -0700 (PDT)
Date: Mon, 13 Oct 2025 19:56:45 +0100
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
	Nathan Lynch <nathan.lynch@amd.com>,
	Sanjay R Mehta <sanju.mehta@amd.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Which amd cpu families support ptdma and ae4dma?
Message-ID: <20251013185645.yhrtn64mwpfom7ut@wrangler>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

I have a dual AMD EPYC 9224 on a Gigabyte MZ73-LM0 server motherboard. I
am trying to use ptdma or ae4dma to prototype a memory management
related patch, but it doesn't seem like any of those engines exist on my
CPU. I loaded ae4dma but /sys/class/dma and /sys/kernel/debug/dmaengine
are empty and I can't see anyting on dmsg.

I cannot find any documentation whatsover online on those engines.

Could you please tell me which classes of amd cpus support those
engines? Is there a chance I have it, but I'm missing something?

I am on Linux v6.17. I also tried to check with lspci. It doesn't seem
to report anything related to ptdma or ae4dma.

Any info will be much appreciated!

Thanks

-- 
~karim

