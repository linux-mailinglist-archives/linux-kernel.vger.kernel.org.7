Return-Path: <linux-kernel+bounces-750464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B23B15B93
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152FC1898325
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE938279792;
	Wed, 30 Jul 2025 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQGCvexD"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969F6277036
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867807; cv=none; b=MqL9NiCqBBi0tblv95tWfnBMQfDq7DZsxcqVkxHYvCdIrT8A6x0SM2+3/U8Z/wf7FCJmU+XrHC9bCoGUGp1dCNCmqho/n4rRRH21GD7kYkgCZhAO223rw4ntK+vvWLLEL5RO6Ba+LZqBMr8DcbGuRcFmmurAGXOYqcvl1RyMWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867807; c=relaxed/simple;
	bh=AMFrLsSdDLsWD6Yxv/Xp7y8nsNQ2tGUP+On1wCM+8Nc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mrjtv0raYfEAaFfEZHo3SNWnDyqUIzhqH70eNMm2rAWqEXVIuDsrpk3VsECSyQCqeipXD6e633/scuwvv965kr7cz93nyvPDSrI37X50nELDxMO0NFzqISGxxkX0W4Z2CyEu8UJuKH5bcnPi4bclHW0zejHUr1NDxj1iIN8KT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rQGCvexD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-749248d06faso5601318b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753867805; x=1754472605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4sv190EzN/L51InyJ6GGaDg9k7LvZRYe9Fp2o+cKoI=;
        b=rQGCvexDqtL77v5LZmfugAbQv5I96nUsvAvw8Z/pKYpMLObcMIOvlragYKp+UAH5sx
         Je771M8bpOEcO/NmefSj11XI50Ciqy6lzoMvO2srm7yV9KOynWMwh+UZoi2Bsu3xHrdw
         tw5BEt/9CMJEUkBolLJ/ibY+erPauKcvVyYBVcMI6yLFmR84kHYPBPQdiZw5FbJxA2k9
         zqtPvkGUbUzwAtGlBVGksPP4ZZxVGK8nUvOX8qdfYLtLPb1LUoVTPZPsV/7hfI8eMyTu
         +JgRolkIMrq7itxUkt2eDKjYhjb3RpoYl88hZiZyJGq6UNVOsEksslGfJ6gbjMoCcWLm
         zjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753867805; x=1754472605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4sv190EzN/L51InyJ6GGaDg9k7LvZRYe9Fp2o+cKoI=;
        b=PX6w2G6OOa+wzKOJvVpi1S4MYURl4WFzWqkpNl1QxAI2zyBrXeOWiDCW/tKdX+ULa+
         pSq0PBW7REHOezsySnNLcqMF/b7q5yRHB++aeM3YRjbYqczOWWLh5qyasl6pYYsKlAnv
         TshUr3g6eNWOXb2v8Pvg+8178UTB7w/H2LPZKXgF+edPnoI0Sfcl3bN1JBlL5yLdabcD
         36tYzBNRVXyX4HQ6K5kuqi7yn+bol/mbYeBXaBKFQlAfi13fxiJI37S+oUnsCZ3DFide
         0dVbTtFrbsoHJwnn5WC0Xz9X4oL0ZNoL7dIhzjqRzdvLW/XUGvWbKOpfon079tzA/+od
         ST8g==
X-Gm-Message-State: AOJu0Yy51M/pd+hCu9FQa5pT8gQn7jxOt8Mo4Ct/c3oFxvobRFXiA7QY
	BDwvOoGqU6ONkjE5H88XFo20fz7xnbcHeUmXflPgpkVNnyUWmL6pgW0qnq+XldngKZa5O5hYOHK
	czkY/
X-Gm-Gg: ASbGncvJSohLKuQHtsrxmli6ZKtIIKoOoDSPXXIn46vvFJe1CWPBb9wO3hhydHCxNvy
	DSENzlAItNBDcP+W1k9RuBeOSBb5JP8qWHBA8pCvDifkTby0h4tIOvqimQCD8BF2avsyoGeH3W0
	hw0o4+sH7UkaS6hSMhcT/6N+9KnP9k6UifdW820iYxt1pj6VbK5trW9YsOyNfDJoo2fMHUJjHdT
	cDjtC+pSG8rzj2g1KJsB9xv/bC8Y7i6lGqlAq33td0QQTV7gmQrTMO7ROG7cr2v6hbGwkCJXFZC
	m3sNDiAYtZf3E7wgYy96qebog7gA2vdlQj6b7KUG2I1sxAxKE+pUnm91uFQLrlsLus7gs0IV1kv
	x0du1xmKq1juY9MwUfmqXkiM=
X-Google-Smtp-Source: AGHT+IHFAGP1HJe5a9qKM+/ZDWC7kbnIisWwtDj1bGJ4lHuGMD0cLNRjCqCmnmGMtsYPaHtgs9ZyQw==
X-Received: by 2002:a05:6a00:ad6:b0:749:ad1:ac8a with SMTP id d2e1a72fcca58-76ab2b55c8dmr4076130b3a.11.1753867804853;
        Wed, 30 Jul 2025 02:30:04 -0700 (PDT)
Received: from localhost ([122.172.85.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-769b53591f9sm3880810b3a.35.2025.07.30.02.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:30:04 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Arnd Bergmann <arnd@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	devicetree@vger.kernel.org,
	virtualization@lists.linux.dev,
	Sudeep Holla <sudeep.holla@arm.com>,
	Bertrand Marquis <bertrand.marquis@arm.com>,
	"Edgar E . Iglesias" <edgar.iglesias@amd.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [RFC PATCH  2/6] of: reserved-memory: Add of_reserved_mem_lookup_by_name
Date: Wed, 30 Jul 2025 14:59:31 +0530
Message-Id: <feb4591cc48c70f9790c3f4d37c149fc336c3110.1753865268.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1753865268.git.viresh.kumar@linaro.org>
References: <cover.1753865268.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds of_reserved_mem_lookup_by_name() helper to get a
reserved-memory region based on the DT node name.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/of/of_reserved_mem.c    | 27 +++++++++++++++++++++++++++
 include/linux/of_reserved_mem.h |  6 ++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index e0a86c3fa656..b94c3b1d14b6 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -758,6 +758,33 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_reserved_mem_lookup);
 
+/**
+ * of_reserved_mem_lookup_by_name() - acquire reserved_mem from node name
+ * @name:	node name
+ *
+ * This function allows drivers to acquire a reference to the reserved_mem
+ * struct based on a reserved-memory node name.
+ *
+ * Returns a reserved_mem reference, or NULL on error.
+ */
+struct reserved_mem *of_reserved_mem_lookup_by_name(const char *name)
+{
+	struct device_node *np __free(device_node) =
+		of_find_node_by_path("/reserved-memory");
+	struct device_node *child __free(device_node) = NULL;
+
+	if (!np)
+		return ERR_PTR(-ENODEV);
+
+	for_each_child_of_node(np, child) {
+		if (of_node_name_eq(child, name))
+			return of_reserved_mem_lookup(child);
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL_GPL(of_reserved_mem_lookup_by_name);
+
 /**
  * of_reserved_mem_region_to_resource() - Get a reserved memory region as a resource
  * @np:		node containing 'memory-region' property
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 3933f1d39e9a..d6d187597b7f 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -41,6 +41,7 @@ int reserved_mem_device_init(struct device *dev, struct reserved_mem *rmem);
 void of_reserved_mem_device_release(struct device *dev);
 
 struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
+struct reserved_mem *of_reserved_mem_lookup_by_name(const char *name);
 int of_reserved_mem_region_to_resource(const struct device_node *np,
 				       unsigned int idx, struct resource *res);
 int of_reserved_mem_region_to_resource_byname(const struct device_node *np,
@@ -78,6 +79,11 @@ static inline struct reserved_mem *of_reserved_mem_lookup(struct device_node *np
 	return NULL;
 }
 
+static inline struct reserved_mem *of_reserved_mem_lookup_by_name(const char *name)
+{
+	return NULL;
+}
+
 static inline int of_reserved_mem_region_to_resource(const struct device_node *np,
 						     unsigned int idx,
 						     struct resource *res)
-- 
2.31.1.272.g89b43f80a514


