Return-Path: <linux-kernel+bounces-755419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C217B1A617
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B1A18A20DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9087D26D4C7;
	Mon,  4 Aug 2025 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhGYaQMo"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96E221FC8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321585; cv=none; b=A0toRiZ9Z5nkRVbATsS3LO6CVCtD5D79puX4y8WO8iITQOSaBI3utOTBrzSa4FLw8xq8aFOtbojhCgdXld7KHnBMIln97ukGMuMONDfH78qzzjMAsgBqFa6J9X/kFSkToYXU5JhMKXF0xN06OUL/NpgDkIYxvKwcdXNJa2asK2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321585; c=relaxed/simple;
	bh=xpPcqm/XbxcyoNrkdPGdOxHZgjFN5JsckdBSTXDVOrQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lmzBaWvRaqfiPnKGy6D01JQhEpKf6kKXiwH8d6BsQw/Sb2+TrXWW3nffwO+FAiXP6jzgDOLmjPPrUo0KqGFZu7J5CkxCaupz65raqDXd8lyHWatraM1kWN9ZjRDHQEF8bULmlcj5H89xboAzG6HjfQCa7zx6OdEx1zCIrwwQ/Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JhGYaQMo; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b8de6f7556so846577f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321581; x=1754926381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGtT0dY3F6pCzUqfUZ/2BFy9sZFKOLTbo2dgZKMNO2I=;
        b=JhGYaQMogMhtk2P71Qqfk0QFumKA3LIpsbtULee9M1USaeSvZPv/2M+1u8elZ7uv+Q
         6NRAVG+kr4nalX+HomOqdSRuZA/WPSgEHAs+5WwR2or+4MpvpHY5/CaGJEOZJI9iTCKt
         26gpGTya6jMctdBkDow7tKE2sI4lgkznVwm8W9QW0yvJwvfXc0mL7GMO/4QB51NFNR0O
         4qnEVU/pYmRXiL7Yh+QjbhKZ2mjt1oqJXMOS0NXxJzrFIQ2dE4WkeJqrLDIHWEhVhQ30
         y5EjgPu+dNr1dHcqaMDKPDbAstGre0uSADx6iCtN5JH9GvBQmX3vbQAh7ZOPFCFvsCkf
         J/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321581; x=1754926381;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGtT0dY3F6pCzUqfUZ/2BFy9sZFKOLTbo2dgZKMNO2I=;
        b=uq8/MFYV3TqHiZRMcmuT5RM8qVBWWrCvoAUbs32crWaN2fvsPJEfThCPd8AqdnV3BW
         7WIhmkJC/ymmDrYo56isFkAmICDGZhCF8oQhXVUOHnsTK9NJnOU08KpauTpjA6+eHsKA
         EX66LOiQ9RtHBCA9pqGZwvNbfnAxsdJ345nifYN7F55Q+mTKgEtQsZ3BL2eTt3Yv+IA3
         5PjdAosB5FwwPWpNx0E6i0R/kEbYJoDAHBuAXPapb8Y1Xmo0iZ0Q858J9ASEn5Toj2di
         YJKYo+pm+1Mavp44xEUa9I121Qu08gguwf02o0diBSmI3gDRXQ/MZMouvuM8fwHlYWBX
         XfHA==
X-Forwarded-Encrypted: i=1; AJvYcCUF/4RhmKmB8KYX9NyEHakgFzVcNqctlRxf32Lo9INadnYBEm9fqa2nVTcey8113kDFE4YzjAwZOL6k8mI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynvf6/nF6oHPJXiD5TT1uy8ADJHqBqhT9cLsZdJZE9UlIBikre
	z030+0NvePQPZlZcjKquTpUgU/uejITFLUglR6w8n4tURBj/hmVBYsBHm1qoEQXT9L0=
X-Gm-Gg: ASbGnct12WPbZA0j+xsp/RoxEHh9tmXc7+BGlP0ESr6B3WSVbafimESP9Xe7+8WvNUp
	GqzQ1WYECiLmwYUT5xIul00zsOIVb/a7ifa7WBohd/NohZtTjjKd6S58vVmgvhwqqAQq7QQTode
	jqEADlGiKiS4mPs5ScPDVyara/rXTb6f0DkjEmD/bZOHndsLGj2qyYmlPLFamN1YNUFdHsmL5bO
	Uy2rYE0Y751Ez8/f+siuCfhJt+/QJjJc5Kw8fMGTd6KxqIA2aoLxYeVVSCOnCezMoNRswVGWvYl
	qf1Au2V4gklF3/MH38Ja630tw7nrxc0yGXYoj5wSv6MtGi+i6NuBW0aGSMrfV0ZEXZYNk7P9BTb
	fqqPHT5wThpIrDZhoh/3mVFJjI+OvU3JAGcu+3Z2z1Vk=
X-Google-Smtp-Source: AGHT+IEw5RuP3v5fLuYYshx6cD3p6FVP/1Yl0UoCru4wIcfyrmaGFBKu5wV8Ia2PqQvV6nm6BoY+/w==
X-Received: by 2002:a5d:64e8:0:b0:3b7:93df:39d0 with SMTP id ffacd0b85a97d-3b8d9470d14mr7193215f8f.15.1754321581350;
        Mon, 04 Aug 2025 08:33:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47ca5fsm15664010f8f.63.2025.08.04.08.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:33:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 asrivats@redhat.com, Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
In-Reply-To: <aIJagJ/RnhSCtb2t@bhairav-test.ee.iitb.ac.in>
References: <aIJagJ/RnhSCtb2t@bhairav-test.ee.iitb.ac.in>
Subject: Re: [PATCH] drm: panel: orisetech: improve error handling during
 probe
Message-Id: <175432157997.3671011.5814829967293718308.b4-ty@linaro.org>
Date: Mon, 04 Aug 2025 17:32:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Thu, 24 Jul 2025 21:38:32 +0530, Akhilesh Patil wrote:
> Use dev_err_probe() helper as directed by core driver model to handle
> driver probe error. Use standard helper defined at drivers/base/core.c
> to maintain code consistency.
> 
> Inspired by,
> commit a787e5400a1ce ("driver core: add device probe log helper")
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm: panel: orisetech: improve error handling during probe
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/640d512caa64b569e58a08b540d9c400e1aa8f94

-- 
Neil


