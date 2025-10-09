Return-Path: <linux-kernel+bounces-847418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD18BCAC78
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 22:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63390352E96
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 20:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D7726E6F9;
	Thu,  9 Oct 2025 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="Pqrxkk+A"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C0226D4C3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760041076; cv=none; b=BM5gCRMTr1HRHbINfO3IROwrIVfEunDNd6Nm5BLvPjwn87F39Dv2XFHqfnnZCftcLirrtjFQI8dy7TN0T+u0wXk7GIpkEdZGFU5/vVaD3HrXeC1UMHhPqFHQERX1BD396xcY1rJSzGuqQ03ezprgH6y95IZulqOvujhw1gVtQDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760041076; c=relaxed/simple;
	bh=yPJWbQEY90/TG+cwwBUl44wg4ZYHXxRi8GBxQs5oFrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fG+yj/kkKR1ruYsQyk2oaJLEjhT3NKGII+crXw6PHh9TKu8sVCP+V7AA+vYPcH3kRSpAuZKhneHXOIWByd3d27xx6L8vVMyioENocvhD5UJ5Ek/snApXh6JDf/OhfcyAHycElp+fRNZG3RVAckAxScFHc28FAAiUhVqskjmJdfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=Pqrxkk+A; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso8540635e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 13:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1760041073; x=1760645873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPJWbQEY90/TG+cwwBUl44wg4ZYHXxRi8GBxQs5oFrg=;
        b=Pqrxkk+AxBwYVuH2v07YpwXFWCUSjNyk7mM3W68KoFS61x3YvhfDM8pZirUcC49jAG
         Q85/UNoNXCUOHpKFdTEjduKLn/TN1sgZmGPl05xVsoVNSFnUMo3u0bIMn+t5eFQyWjtX
         t1vDtZK7cpgFDAXq6Xgv3WniXdh/Zsmt8myT2Fp3EgP+EFCOsPxUNsy4vg+FMQEdI1Tn
         Egq2uX/z/m4+iaIwiWm32eEPpgT88w1MQiUzPNr39a9YzLr5sQe42+F+2BCSy9rDFOsw
         WzXnYYPbeDczKEz9+hFdutTfUMuqXQ7+fEub0/1SjnEc/XvUUTvv2P0lVjQh6G849tbm
         X4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760041073; x=1760645873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPJWbQEY90/TG+cwwBUl44wg4ZYHXxRi8GBxQs5oFrg=;
        b=UaUQENdf0YUCs3l2efe9SNMZspnbjTTyl++TsqQ4kti7+/4o6HR9kuMf8r5CAax2f5
         Mk6X1Q38n90yLqrG6sYqATpsiUZqvlGZwIR6tZTU9hB93d/mvsWk4I6OF0LoINdVZK5M
         S+PUBEP6NDqfysk0bjUW86mS9XVPvAACuwMBHJss1fBvzBr6stS8KfNgwgJ+F0aXx9FV
         8C4dRGkaOJDPyjvnQgguoSr9+lyg3l2ZbAwx8Fw1vHMfwqqt9Fe8ePtK9K35vQHm5rUb
         IfOJdAq97kW41x6R6FWTRB3JZBNbJi2g17Ta38kiZOtRMPC9BhzO6BcDiVv1Ga7Im2d3
         9Y6g==
X-Forwarded-Encrypted: i=1; AJvYcCWxE8G1HLH92cKgdKKZ4uGJQa4mOlCB5SZiO/vHGeu8zxyAsjRawimyIOhLx1aaiJ+MVT6ElJYsmvLUW2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIoeR8V9DIRab3FnqvuRH+wuPdMC977Meqg1FUBjzurMoFgG6H
	A5QvRId/u8PKnMtNjQiRgA8ElNBeQA9lK7YYSfYmgI24zDVoN5jyqZhgPJNVyF6ZOzY=
X-Gm-Gg: ASbGncua8tx2DrWiIer/+046zUXR+y6bRifq5T7CuC8obyHGjfMtSFaf85wDvTerD5y
	wEPkVeTMN8lV8btlfAmR7iGoAu+wPaR3iWKMqh+zBeMOjyFv0mWr9Wo+EWDdR3+xDcyCgo+Ja6+
	EcqmkEiP3DrE7xXla6kzCLD5ebYzm3ezxp7+MOXuE7SOc0RArEPJ+6B1CJF6vXctoA13mLEMC3s
	dh8Jop4KfxqcOYmtmB6nINcJhDGgj4Ft1R2Ke4yGp1B0TbklGpSt6VNnpEe79firnAsN+1yOw+9
	NyBIEa3iBBJdzg1Gghs7hrHZtT+SSBuUoI6/AkJ6vpIxAizOJomxXGFlGzlpf7bpOMgsxJAHfIs
	2RhUOf5Dh+Pi5tvC4rT0zUQ2Xd/68Dh6N2bUyjj+HRA6PiJD/wLgbz8P3jlhJJxDAPAXGbQ3H+H
	c=
X-Google-Smtp-Source: AGHT+IFAX7+/e5dnmTL61t9BVALaD4efIOwMQtslWhHo9+H7zMZKmhsltEBeuzKspmSb6DMT6luYgw==
X-Received: by 2002:a05:600c:37c9:b0:46e:477a:f3dd with SMTP id 5b1f17b1804b1-46fa9b1b18emr63175235e9.36.1760041072479;
        Thu, 09 Oct 2025 13:17:52 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:3fd:ce82:c5e3:a5da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb484c71csm12836805e9.8.2025.10.09.13.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 13:17:52 -0700 (PDT)
From: Aliaksandr Smirnou <asmirnou@pinefeat.co.uk>
To: krzk@kernel.org
Cc: asmirnou@pinefeat.co.uk,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	hverkuil@xs4all.nl,
	jacopo.mondi@ideasonboard.com,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: Pinefeat cef168 lens control board
Date: Thu,  9 Oct 2025 21:17:51 +0100
Message-Id: <20251009201751.9591-1-asmirnou@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1b5f080f-2c18-43e7-9c47-b5b09847c51d@kernel.org>
References: <1b5f080f-2c18-43e7-9c47-b5b09847c51d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 9 Oct 2025 08:46:44 +0900, Krzysztof Kozlowski wrote:

> You already got review at v4! Why are you forcing us to do the job
> multiple times?

Apologies for the oversight. There were no changes in the dt-bindings
patch; I should have kept the Reviewed-by tag from the earlier one.
I'll make sure to include it next time.

