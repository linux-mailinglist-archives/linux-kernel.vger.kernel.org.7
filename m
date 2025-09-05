Return-Path: <linux-kernel+bounces-803429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2214CB45FB6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420573AB46C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4643630B520;
	Fri,  5 Sep 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qU7oBBQX"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF53028641E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092208; cv=none; b=XRAzrRM1clWenpgSOyl0Ri1RMtpFvjbXBAzH8IEin9Yk02t7goWY7/usDaTssQijvmzpuoiOeQOPpIoj32o0cyfniq6EaDRt7ZVh/ffH/mVayQL/0eDILYse/f4Rpu/V1ot1hUaB9EPNeQP3FUn0GYg5VRTmZqTdcdTdBdRRb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092208; c=relaxed/simple;
	bh=+KDLBmLuOlgXUMQJZW9aFUYy2wuEz8TMCV6o/Ec6Qc4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f1NAqKIx7UxElIZoVIJ8/fO6EhpjmKuktCWeni1SQDZjvhGURmYez8fWFOVt8hZNsdXYadE5zeqBLrP1aOCeOsjAIF/Q2+izBZ+oK8dsdRY8RLfE0JZ9tBCaeuEjoptsyty4gbunwsDHifw8To6MU124rFk8OJImju3JhRLAV28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qU7oBBQX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A5AB21A0DE4;
	Fri,  5 Sep 2025 17:09:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 74CA16060B;
	Fri,  5 Sep 2025 17:09:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0EEC2102F1C2A;
	Fri,  5 Sep 2025 19:09:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757092197; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aOT3KtNIKMIVd1m+1jlPmG8mf0Vynysjr8mE//QpKn0=;
	b=qU7oBBQXwXTAkW7qRt+m44PVa5coMfHtx5ZoFi/HfPEhVH6cbEpB5xdye7T9bZ+OH2NZ85
	yJbXSxClF91OPLMVTX3t0KMsAm/q9IZ1JrU1Z9z9fW/ARYebCOh6/+3Kc7zmfvrKq6s14O
	CNJtjRkDeM0SR8uZyn+A516kbMUs2/WfyI8+qK3eCMBH51C2IxA2WmybE4GPuWvyU9+G8F
	1i5ray3iAHRC0bpY0kKkEOQUAjOKIOtPeSZ15jRE5TvUFaK+RaTjniwEwM0IqicdmDHRvc
	9DoG6wS/trirDadWa5ozTJkvz10R0WKa3MSnIi8TVaC8RJZvvxfRyX05qDPLwQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20250811101529.150716-1-jose.exposito89@gmail.com>
References: <20250811101529.150716-1-jose.exposito89@gmail.com>
Subject: Re: [PATCH] drm/vkms: Assert if vkms_config_create_*() fails
Message-Id: <175709218483.1237020.8619075932640588884.b4-ty@bootlin.com>
Date: Fri, 05 Sep 2025 19:09:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3


On Mon, 11 Aug 2025 12:15:17 +0200, José Expósito wrote:
> Check that the value returned by the vkms_config_create_*() functions is
> valid. Otherwise, assert and finish the KUnit test.
> 
> 

Applied, thanks!

[1/1] drm/vkms: Assert if vkms_config_create_*() fails
      commit: 0d2902dfa31535c08d4976995d5b6890a8f43399

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


