Return-Path: <linux-kernel+bounces-729852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BB1B03C77
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE6C17E930
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA677247290;
	Mon, 14 Jul 2025 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNeOEmbK"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02A42459E3;
	Mon, 14 Jul 2025 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489953; cv=none; b=uSKaED8mSFOlBFHvnTHtrluBicbEss5RWgcIaLQps0DHfIKgHuRIIAyJ8dpDvExw11LtGugkLBsRRJwX1GhXbsznrfyNYt8OjVuhMw9FF1phRYEB8DB+AUw7kkt1Ur7XSF8EareqztRT3RG1iHloM7K7wxO7pIViC0e89XvKROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489953; c=relaxed/simple;
	bh=CB5puZj3RBaasged2EVtetcUkyYF+GpbLfj3hezh1mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiHzgj3dATXfiDvbqHrmNw0wDKrAqljYF3tSIGcYFvDm48ZLllNjrBmBisWvNcfWYhWDqhTNb1vi9WfvJ0GjachoNkj4jvxQBEaI+9nNu8bTqAJEgd+Y45pdRBVod6U7E8RE0qM4l1pRwZkvk2ruDH9neSIEyVoYcAXCqH83RGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNeOEmbK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74af4af04fdso3906074b3a.1;
        Mon, 14 Jul 2025 03:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752489951; x=1753094751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lACXWrIyx0XepFzYp8lYN3B6VObrUZBjQ6Rart3u69s=;
        b=UNeOEmbKyLupy76kCL5Dnke1hsMMQ4+BwCHKyJ5xhYsgOwJvD0/A5i/TaJt5B88f5A
         96836KeWIRHFwo6xSKmToRKjP5A7076aYkNUe9NhOVxR5oEe5y+/qKvXt7iYXCT4fOEP
         9tBBSLnk4lxLsyexqhu+5vEoxaU+vZQKx0TUkpKOCVsjLxzCxBmdSeDHjfCnnbUvHF6g
         HRWnh7fMm1PjhfmidEC2CL/izLU87ekx0Ks2qD5UnwM39CMcDyjcuajmrF+UBE0rOw0r
         N2f5aUXi/M0q9zgY7z9uilwp0RiTqjvAzk8Zh0TG/G5Yzs0LtYFUHP3fGT2QLmSk/+9t
         xcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489951; x=1753094751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lACXWrIyx0XepFzYp8lYN3B6VObrUZBjQ6Rart3u69s=;
        b=XILl7WeHbJYKlIjZxHlucDoqqZrlHlcIWR/nC75+LA0eRDMECSKu0vxb2AAEk4WqmY
         4d6HNLN2ttpr7SN3llKyDlJ8aFwer1P1Vxh7ADshO/7vydC+Xl+wWM0bJWIlwWHYYYVD
         LfB4TYBTgXGbd7MeSmSUFFvQviscmIdNamztCxU8MDvyQbEuSXzlSj+6qBVFC2CyKnXn
         gP7lU6bDJgNYlvNUBgRoS4ztWC8I8+JdBB11u+OywIWXvLTYavY/PACeYGHQdigmvHTa
         xvTdW8SB5lagIObJJAGCXbolGMR8a3+zjQIrduPw7O6eHZmL+celkAFBKftiEh7a2/+9
         oA5w==
X-Forwarded-Encrypted: i=1; AJvYcCUwavSkr4rJRdFvyS9KL4JBarat5SUT5PvD55L+Gts+3q5p1GYMHEUVd+c9aaKuwGdW/NCFCSXyy7sWbfE=@vger.kernel.org, AJvYcCX2ybGhI0MqLCzeiWNLVGnCiKiyp5DmzzhDZN7zuWbnMpY9a2ErR/uZa6E1CXFtjQBqy2MmjpiRjslrZf2xn4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeqgglBcd1NoWG1oR02r11tWY90luGLbit3/BrFjEVsrKD8avF
	PVKCwdnD6Rb5iCqb9iXuF1XqMnmGQcuy5DUkrWalbvTq8d//6I0brxZA
X-Gm-Gg: ASbGncudkZmvsVJe4QlH/jSk3OQ3hbNJiRHRKA/b6J0DIxSJ3/xeazwN+vPyJ/RaK1z
	3dDp6hz0GRrPxWLtvyf9LkjB4XlViM9o6Z25F9dGz1e/DaVo3fWUqUMgPDoqSPHR/ZzTynyXTdS
	uTROBIJMytfgRCV3QnbWS0fajGbC7a6pHWACPWAEBdqKxZX1ZYEOe4cTFxriyGZWH+xSSwyKjZV
	xGvUh1UlFUhGVun44S4i4myTGLgRU+fKP/SGyePbySDcT0OdORi0WWzuGbLROkGygNDCQIne/Fe
	2uj08BX89KZokPpJI8PTY+GCoOIMOLao/znZYTLKar/UyldRnq8tQMt2nLlkwqTNPEQQBFK4NPI
	BlT9giiw48okSwqT7v3LjviFR
X-Google-Smtp-Source: AGHT+IFLPKx1BZNNAyFNyKEkIkORD8Kmtj8nI6gAHdSOXogrL29N95gdsu5VKoCLvgamTF6GYkS1+Q==
X-Received: by 2002:a05:6a20:9d96:b0:220:898b:2ca1 with SMTP id adf61e73a8af0-231285725fdmr17928439637.21.1752489951050;
        Mon, 14 Jul 2025 03:45:51 -0700 (PDT)
Received: from quat-desktop ([2001:569:514a:9100:3f23:7b0f:f6a2:1ebd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e058fesm10320909b3a.40.2025.07.14.03.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 03:45:50 -0700 (PDT)
From: Rhys Lloyd <krakow20@gmail.com>
To: acourbot@nvidia.com,
	dakr@kernel.org
Cc: Rhys Lloyd <krakow20@gmail.com>,
	rust-for-linux@vger.kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: nova-core: vbios: use size_of instead of magic number
Date: Mon, 14 Jul 2025 03:43:14 -0700
Message-ID: <20250714104322.100511-3-krakow20@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714104322.100511-1-krakow20@gmail.com>
References: <20250714104322.100511-1-krakow20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

12 is identical to the value of `size_of::<BitHeader>()`,
so use the latter instead.

Signed-off-by: Rhys Lloyd <krakow20@gmail.com>
---
 drivers/gpu/nova-core/vbios.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 663fc50e8b66..ac35415b4ffb 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -365,7 +365,7 @@ struct BitHeader {
 
 impl BitHeader {
     fn new(data: &[u8]) -> Result<Self> {
-        if data.len() < 12 {
+        if data.len() < core::mem::size_of::<Self>() {
             return Err(EINVAL);
         }
 

base-commit: 215a3f91713383a3c0d2da82d223a608a3c17ac1
-- 
2.50.1


