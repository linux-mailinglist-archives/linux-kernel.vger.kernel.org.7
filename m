Return-Path: <linux-kernel+bounces-793336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2FAB3D206
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F48117D861
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BE12472A8;
	Sun, 31 Aug 2025 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dq7vrm1f"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DA622259F
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756635231; cv=none; b=Z+k6ED5yT1USnG8spVa+t3+rW0hKsTqWAyCdyL1CERbxVmp8S/DxzUR0CkWMRMCit46isWglLvCcii99S44Tgrz6+PIsCjoBXt763EapZn94OpKKjSJKnZZU3CaOkJO1i4ahrkcduv9N2FEb7clnBMu/XfTkFHwt94JuNL6lNEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756635231; c=relaxed/simple;
	bh=c2RgDDu8j7wlyLwpBe1ihWu4sGXYeLTN1vrm4MajVac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYPDBRTFhyjLQJ6HyWZCo2zHMSjv0EVXVvqGxsrlr3W9VGBGA3SsvlRm9DyreqJGdOWwZ42f3ViY1aRjP/jY03NvE7iX22hvyurLKaRoKmDY13zvfkRDcfx0G+HJR0uEIiuNlvy3VWFnbIGenx//jcTAc4pe96lutu3bhXaaNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dq7vrm1f; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b308ace753so32348171cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 03:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756635228; x=1757240028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OsZBUlaMD74NHBJiDTCM6ecGx0NSFXSd/05ja+XFyc=;
        b=Dq7vrm1fW/22/O2juP8pAMVL1c7zuxv8XfrRgIf6FHXYLJZBAKJsuGaqTLjFo11Tmv
         xC/eiyBGyZcrWw1uN8hz9rRhug7EEvE2BbUyii8QRHZaW+8bg4Gd88qcBnM96BD38iFu
         tqq1KoBx7x6uvdorFoT6MceIy4HDl6KFjLRl3yqX9voL6PsmzpTNShnc9t+z2l+rcfXl
         Ft18ySgG+sIRux4poTVfr6bvWvUDDxGDXwg5XAjVjtQkCqXLRweMSOwE3FtFV7kmsWv8
         N3YGET0uBKbln2sxc4zXigjYPq8OMnIWU3YK9t9TLQTvY4vbFoMot9PN1NPqKETyLbH/
         mnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756635228; x=1757240028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OsZBUlaMD74NHBJiDTCM6ecGx0NSFXSd/05ja+XFyc=;
        b=jTMqF6GHM9AeGXD7olcrEV3x14WY93BZWg1/MmahotopgY1n0p8RjjndBramN04G1Z
         Phzc7kofh2xNvsWkULuYOD9DCFHeo9Gr87mNT3OcwdlQHeqnI3/6YgHuj7zMCwoxdRbz
         wmkVhPK1IF6txDmOTrrtwkmAgWOoOe9sY0OPfREvqt0bvoYyZ5FmWBMVoKQeMHEKDtYt
         K8Q3cA9VyFwfRj7LWpBqViGqb/l7PWcpwLVc7sPHNnYI3jRREZSwAP4sZI/+aBXd9LNc
         BTxibn24CauJY8ziDNH2tJWP9pXhlVT8nEoRcGoM8zy3h2hlxbnQJPwmpbkO2qcFQ2O0
         lW9A==
X-Forwarded-Encrypted: i=1; AJvYcCVnbtRhUJiGeamx/0V4BLpRoGcivi+vkQKi/AmQWmi54EpYmIl4xABWsaQ+sYNerLDBhOAcUF9Dd9OZq4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg342RU5cE+IX8u/oA0v5fqTx5A6EjgOC8u6sUs4RnlUjJNP4E
	kwizOags2XupbKV39p3O3c/C7zjsbpOyKrzP7i/VYYu4rDUNwCfGN+Ip
X-Gm-Gg: ASbGncuvQFYq3ZGM0pYt7Xu3LfrYx3fvErq5mwHEb/BpgmZA8UaKuqMkOhpdfOIKAR0
	uqYSjHxQ0qNDFM3KO4f0pBa9gkg/LTPOfqdCzeJtbZREoodEHHapMWyyd0C38Ajy0Mw9IwG1NPY
	0h45MSa0ELDfcQjUqXdfxCyk57/5ffO9q/IdRjNaqVrZgBuWq0MDJ6hqy3P4IFKVZxaPR5HcxXo
	Bkbp5Upu4OpfINJBTiZ9/v72gO08P2Q+zsW9EWlRaFUROqAwQz6poIe9mwozX81BBTfLdnkjSVM
	KjEJjmezpB3pJK66Z9e5IJwjyV7QqOEOZG2v0S6WURH8V+cj/azXhiZetRAzN9SJHNPFECltB+Q
	+1/VJuwOeUBja73A99YI8k7TBYGbI4QlOcFbmAaOSTa8yjE1hVVzJDEpL8G6JJUiy88Q=
X-Google-Smtp-Source: AGHT+IFVNcOgA0ns1XF9ppSl7P/mNfpzB9TLgDVvgSUFo2YJMrV9HbKJTSL0FDPOW6arjd/eynT+qQ==
X-Received: by 2002:a05:622a:303:b0:4b0:77a3:2b12 with SMTP id d75a77b69052e-4b31d9fbbd8mr46897851cf.28.1756635228586;
        Sun, 31 Aug 2025 03:13:48 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:1bcc:1b67:3f57:d21e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b6e98f7sm43727141cf.46.2025.08.31.03.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 03:13:48 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: Ryan Chung <seokwoo.chung130@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] trace: rephrase for clearer documentation
Date: Sun, 31 Aug 2025 19:13:29 +0900
Message-ID: <20250831101339.11324-2-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250831101339.11324-1-seokwoo.chung130@gmail.com>
References: <20250831101339.11324-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 Documentation/trace/boottime-trace.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index 3efac10adb36..651f3a2c01de 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -19,7 +19,7 @@ this uses bootconfig file to describe tracing feature programming.
 Options in the Boot Config
 ==========================
 
-Here is the list of available options list for boot time tracing in
+Here is the list of available options for boot time tracing in
 boot config file [1]_. All options are under "ftrace." or "kernel."
 prefix. See kernel parameters for the options which starts
 with "kernel." prefix [2]_.
-- 
2.43.0


