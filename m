Return-Path: <linux-kernel+bounces-876018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A75C1A81F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55739568068
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C60333CEA3;
	Wed, 29 Oct 2025 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bhGyUaCa"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134B37A3BA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740933; cv=none; b=VaQvIDk1PcxWRpaNRERFSy9nDMNP0aKjuhZZ98Pl17gdC6ksQr3Q/2GPjOMydMSDZWVxgXCSpWHSzXQktK+2DWVEN7ypgqkboHfK7GQ4L14mR8Hf4hhNOWwPcdeV4WNa/v2xqBE9heBheq+Pq4gU5kCyv9rAMKQVvGqaQW8I+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740933; c=relaxed/simple;
	bh=skajDdkx5Zlz29MD/hcb1hp9VY6nNzXDfPCVk14jKnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dd6VMVwZLOwyEP26gtBsoPi2deLEjnYyyLdKnoS80LAJYVerqaV6U8mL5JSrsKyaDxdOqDRs9UW4RPfbVbBIG66Tq7qm75cCYLXG068Xvjd+mE6VOcD7fyIZiEXsmFPoihE+JwVb4+PGR5luyn9gMdHHq/yr4aQQAGjkBNrhM+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bhGyUaCa; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso60714915e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761740930; x=1762345730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADoOM/VSdH1svjCmremSeFtxhsEEw1L9u9ya69bdw08=;
        b=bhGyUaCaORuWVfs5DVPcbvoXApWKo8dIPj5MxCpDhIektHQyrYReZujhjLopLp3Afg
         wRQT/VILxWqpPKe/AkqL78SwfBKssLaTJCLEbrA10u5y9oY07EpgI/0zta3DnOb2g1Pf
         D4f+ogi4p6aqm/qynSTh6lK5OcTsgeDQkYPyhmN1bsP8CTKnhvUQdLXwWLgzh4gjnfza
         ejGOIll3YQIvi8oGqlSVUNKrvbk0XFu2zkwbHHzZNu47iu059X6Mxu5rBMNHp5aF7u2/
         Q6DpGfHiPspeKj67rA4iDSSabsQlmhdCBPYczTfgne51aaEIV01hc8gNhgyDtctB6CK9
         9PvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740930; x=1762345730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADoOM/VSdH1svjCmremSeFtxhsEEw1L9u9ya69bdw08=;
        b=MDS7ICamV1xIDi89jWMqYYRkEu12k4HGlsdoTcpfzJ+LbpERSlqc5fbtgoQ9xWx7I5
         ML8lnPCvb9CEOk4EFWimEuS+zz51CIpvax9GYSso5Xo3lHVxkYjyvCpGeZ/8i4aNyylx
         Q6wq2Noake5zFNsnnM7T/6DSxwzNEqUz9LUlj9qusZp8uawt4WvwLSvOogL+RVKp8ni3
         mEV9bqoAbLhOqome3lwwF1KeX8C2mAJRZ6pkPYB5UsP23R/D7yyu++MurP7zrZIbYLEY
         DEJrlffS11AB+Poxnl1OPRaF4YIU8lkl5XZUL6iaHhwzaQdVkAXEjWmxHDy7tAazAHkj
         Lgog==
X-Forwarded-Encrypted: i=1; AJvYcCVNMdafz5JN0UmQSq9iylv3tJsL8z2NMJV0wuueyFXY/QlAaM9Y9NAO2rC9BBNmUnzWGS4uX/CRXWsrVww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdl1gA20I9vpYP1ODopu/3ZbO3aKwvkYckq82S901253A83GkH
	eJYeKrvyxyIaD4QrDA9U7tCVhoXrW++IHOqHFnUs3OlVM97JGmUYVm8vxQByDjZvw9k=
X-Gm-Gg: ASbGncsMzjjjKiqjxTsCcxtKuw3ats6iq3W3fhQlQEfj0Q1P0/Ce7/C6VLdlDBJIv8P
	NagHSGxjxbl5Cy+hivbMUC01VO3sN+pKfn9P8rn/dYOErLSZoaeCSvwhvJTMcaWEC4M1DCCbbDR
	ii23Qlz9r88pUQDSMVrzC8WuFgzfGbUkto7cJuAM4u+HiDOBtgNWGfWbHKUJsfWLiOhzx4a8FXl
	eCSNCzi1xHOvQZRh2nbXOoMeK4JC1K8zIOgngZ+VSMqk42e56S+572+R2pshwbJv+yJzV4plI5T
	L+kw6nVnGzVRKpp4rWUrl0c3PEPqymE+n87E0FpKufCZsGegrH1qZotHQeMbH1/yx/gvdqNieER
	3HK50CmM3GNtgJRFMHJ9OGvsanE/9eOSOSAxKuc4dn9VB3TsfNSrt1XPkG5nkhVy8M8IhkPz7dF
	6XNh7I
X-Google-Smtp-Source: AGHT+IEnJ+WhxDkZIJ9MuK8VVXfeLR7pgxX7wrR3Cm/oHex4VAz3yq0JAGJ++1/P5p09YcF3eLjcTA==
X-Received: by 2002:a05:600c:19c7:b0:471:1c48:7c5d with SMTP id 5b1f17b1804b1-4771e166d82mr26066235e9.5.1761740930278;
        Wed, 29 Oct 2025 05:28:50 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3a88fdsm52775545e9.10.2025.10.29.05.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:28:49 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:28:35 +0100
Subject: [PATCH v3 01/10] software node: read the reference args via the
 fwnode API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-reset-gpios-swnodes-v3-1-638a4cb33201@linaro.org>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
In-Reply-To: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Y2y5LmjezurCeJ0tOGGS7EN2B+Sg4Y820lPpRdnBzxA=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAgh987Ua61Y0IHc7j94O0sWWeNpeijiq+Xbgr
 wfDwuVD52mJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQIIfQAKCRARpy6gFHHX
 ckbxD/oCf8GthQZQ7GAyEqL3Cp8rHV9kzEeP4bRMf8hbbWQ6crNOn6AD90eeOPQWrjJV7Cw/5TN
 6W/V9WR8drBRKWdVPi/MR225bdzh/5XiB+cbd0MD9EYti+ZHnVhNl7oZCo6znnSbUWrH/F/NrUg
 N9/vhAGqBKNyRuMHx6j6glju3nIPjQlkUzhsBKGVwg1ck/YjLvJDTM9Nfc3U5qgw0nCDrUSKb1Z
 TEGVRUn/Iil95LGOOXxiyH8gphD8shbuWaJ6NIzw3AsV7+uv+cRcU/g/wjHz7hoG4QrjvAAEqU+
 BVO3hupD1T839IPqvH1iI5kop44Un/GSXbWjBPsNKjAEeWD2rODIUwPi9GXB/swy1vD9BZeHKWw
 DDrWgyJPqB+AbqY2USCKuWnK6oY1zzC8+Jp5GzzdTvqtbF5lbS/hyyK5RMeg2+nmte40ZALoWQy
 CcEUp++VF/hcAYBcAB8eHy/BT4+CxFTDvHHHRhXGlza20bvOWtoYMhIKkqUQdRKFc82C+gWLqTv
 U0BlsplZ4fMLCorbOw1ga9RMutjTqa3HgMXMyDlPtqh1XUuNuTBmun/zJ0/SY3nc52JHjUeyk+8
 I4vTIPgV5FVTtP/CVYlNdlo0Qak5FRjLQSj4nPcmp7JW2sHwVddmGCbyTKd2uQPpXEoy01izuxW
 ipgFJ6rqkUTNsrw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Once we allow software nodes to reference all kinds of firmware nodes,
the refnode here will no longer necessarily be a software node so read
its proprties going through its fwnode implementation.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/base/swnode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index be1e9e61a7bf4d1301a3e109628517cfd9214704..2994efaf1d5d74c82df70e7df8bddf61ba0bfd41 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -540,9 +540,8 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 		return -ENOENT;
 
 	if (nargs_prop) {
-		error = property_entry_read_int_array(ref->node->properties,
-						      nargs_prop, sizeof(u32),
-						      &nargs_prop_val, 1);
+		error = fwnode_property_read_u32(refnode, nargs_prop,
+						 &nargs_prop_val);
 		if (error)
 			return error;
 

-- 
2.48.1


