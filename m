Return-Path: <linux-kernel+bounces-883306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8678C2D152
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57653BBB51
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07433314D22;
	Mon,  3 Nov 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrEAoAO4"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353B30CD93
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186256; cv=none; b=iI/o8N68EfJQN3hs9j4wjwm6/6qPhPA2NJRh2+c0yFrlStPlLJUqVIltCjbIILWawmE1hP42m6rIYtupQJvKu3kDpWyvqjiDUCqO+u8GzVwElnnLTG/WZl2J31SUNB4OU5oWlTq5XYrx/sbSQUh8yFtLSEhqp6575095k11JOjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186256; c=relaxed/simple;
	bh=ktlRiybfVEE4M9mS7/vq+nrhzHGkjir61sJqYVJa+ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RNhze1T0Zk6EiM4c6aFf/6Sqx8VqnzNPwjxy/RtPz1kbYy80tMsgiU/6zFlWxVDKj9u2AJ4hG60bh3oCD0F2Onij5yLF3+q7F/ItBQWnMTCTOi4eKW4QMFjbFbNPOsVbHVeUmkeNOz2ldOYh2IG/gcVATxeF+MopWDAcqCA3kh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrEAoAO4; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-378d710caedso41437871fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762186252; x=1762791052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cFtPE9g4ieXWJSfE3Mqom4niwcqmKkIZ8WbFN2jJcvg=;
        b=nrEAoAO4ZpOQALrpx1tIpxmRjJ+0Bck3VVr5ytZ7wpDrK8S3KY1WDAlk0Uaw55Mh+p
         jUpQS8XspuoByl/YltxviIGmeNl9WXeLOGXS4V52OT47zKUdnLDQcjLYe2I+YxJ2LUMR
         pOBgDwn/4E3B/zn5Y6IRp5xlBXFZy1QzUd06QGA2pMCpI987IK/EOvZt+o17dlnmm+fi
         jJviZQFdqBE9O9WYf/PFJPPESsuboI3qauxu/KcCtUXx6pFvOogAPFE6+d9Qxihgos35
         sfVjrVuI+7U8AeHmDZTh9ZOWt43cYoEotYTx59Cu9Un9GzhIAzB2UmN6Kd6GcWUA4rni
         wYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186252; x=1762791052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFtPE9g4ieXWJSfE3Mqom4niwcqmKkIZ8WbFN2jJcvg=;
        b=G26+NKZO4wZC4yJ1SH01246o+IzAsBZqZFz06D1WeB6ZXBEKfE4b+L/KC7x1yM8A67
         rN/aybr8EaOdb9AYlV0aFndltPnLo8JKbIqDZWHgY2GbOlp+WvFWswRccxISxT9kOIOQ
         rKtrN9Hh4lpyNX3Fq2jT0Uxz8dkMnfooP00NbW7q9wEU8OQACBjNm7GPc0WjdjgEX5QK
         lvhUY6e+x0ytoB8KBaOZScuqp0AsWu0Jf2PfOBRw4xEEnQojusP5Q25rFHeotGv0OJkN
         AGLBu0GcngVfpN9cx6uSQcVUieRFGpL6ufSBqOVQBBkm5v+QCHKeS5mmIVcKtZ2YCOl7
         p0CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX0pfnHq6wvn3s1LeZnN5akCOX8OE4NIw/RaWF1Ca5Wk72mZ6BCnAtdhfmsOdzXQYeelxQAR+OBJZKX9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vT7nw+pFwdy6GncKU1o04t5BnPEZ4NBvTH4mofUqJ+60EorE
	ej/pNRf2YZ7VYZ0P7QS37zS+bNF135zjqX7XnlohgOxaxeq/E3m+RZh/
X-Gm-Gg: ASbGnculX8/ylASAkT/c4mYEspGWgw4x4YpDt/UlJigQiyFlEHousTlO+ZYZZ6Nac5f
	kmwtq5sDRlVEtycgZy7DIPKa7vHZHADGu/uTU0R8w/kRSOS1l7XRppi34un3eKjYdqIHshNpNib
	qCULNbPcbU5SlCsjuLVMK4GCe+f5NxY6IqoLYlMBUYsdaANt4rKzzPQmKdgAAkobHHSnbN/ndG8
	iE7h6N2yVn3XkQidThvbJN4XRa05QpkGJksSeGCbiXWFDrTZuHl+uwpQKf3xi2aY4ULwihaEPNS
	+DCTwnideF0+iMt/xY4g0JjFWFqMXbozmaZuSXjyipw1L4Q36padOaysCBozVcNvQ4t+olDTmOo
	Jz6RZryQGmqA7KI48qDDE+SNemuof5yMuITtuoaCURUgzOw5Td1aHlj65M+9rr4hU0ASdoDH4Bd
	g=
X-Google-Smtp-Source: AGHT+IHi5+1WnUMMnmI9WW8vac117JgHMer+uQjCtLqpPudFJmKKnUMgQHR5NcfnfbgtqZCF7Ymeww==
X-Received: by 2002:a2e:bcd0:0:b0:338:8:7275 with SMTP id 38308e7fff4ca-37a18dfbddfmr37782521fa.25.1762186251889;
        Mon, 03 Nov 2025 08:10:51 -0800 (PST)
Received: from NB-6746.. ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5943443966esm22772e87.68.2025.11.03.08.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:10:51 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: a.shimko.dev@gmail.com,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] scmi: reset: validate number of reset domains
Date: Mon,  3 Nov 2025 19:10:43 +0300
Message-ID: <20251103161044.2269377-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add validation to reject zero reset domains during protocol initialization.

The fix adds an explicit check for zero domains in
scmi_reset_protocol_init(), returning -EINVAL early during protocol
initialization. This prevents the driver from proceeding with a
non-functional state and avoids potential kernel panics in functions
like scmi_reset_domain_reset() and scmi_reset_notify_supported() that
assume dom_info is always valid.

The change is minimal and safe, affecting only the error case while
preserving all existing functionality for valid configurations.
The existing -ENOMEM handling for memory allocation remains unchanged
and sufficient.

This change ensures early failure with -EINVAL during protocol
initialization, preventing silent failures and maintaining system
stability. The existing -ENOMEM handling for memory allocation remains
unchanged and sufficient.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
Dear SCMI Maintainers,

This patch addresses an issue in the SCMI reset protocol initialization
where a zero value for num_domains could lead to a non-functional state
or potential NULL pointer dereferences.

Currently, if the platform reports zero reset domains, the driver
continues initialization but creates an inconsistent state:

    ret = scmi_reset_attributes_get(ph, pinfo);
    if (ret)
        return ret;

    /* When num_domains == 0: */
    pinfo->dom_info = devm_kcalloc(ph->dev, pinfo->num_domains,  /* 0 */
          sizeof(*pinfo->dom_info), GFP_KERNEL);
    /* Returns ZERO_SIZE_PTR (not NULL) */
    
    if (!pinfo->dom_info)  /* ZERO_SIZE_PTR != NULL, condition fails */
        return -ENOMEM;

    /* Execution continues! */
    return ph->set_priv(ph, pinfo, version);  /* Returns SUCCESS (0)! */

However, subsequent reset operations crash when accessing dom_info:

    static int scmi_reset_domain_reset(const struct scmi_protocol_handle *ph,
              u32 domain_id)
    {
        struct scmi_reset_info *pi = ph->get_priv(ph);
        struct reset_dom_info *dom = pi->dom_info + domain_id;  
        /* ZERO_SIZE_PTR + domain_id = INVALID POINTER! */
        /* KERNEL PANIC on dom-> access */
    }

The protocol appears to initialize successfully but is actually non-functional
and will crash on first usage.

The patch adds validation to reject zero domains during initialization,
ensuring fail-fast behavior and preventing hidden failures. This approach
maintains system stability by catching invalid configurations early.

Testing confirmed normal operation with positive num_domains values and
proper error handling with zero domains. The change is minimal and safe,
affecting only the error case while preserving all existing functionality
for valid configurations.

This patch fixes a potential crash scenario while maintaining full
backward compatibility with properly configured systems.

If this is a working case, I will check and supplement other protocols such as
sensor and power domain.
--
Best regards,
Artem Shimko

ChangeLog:
  v2: Change commit message

 drivers/firmware/arm_scmi/reset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 0aa82b96f41b..458b75fcc858 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -358,6 +358,9 @@ static int scmi_reset_protocol_init(const struct scmi_protocol_handle *ph)
 	if (ret)
 		return ret;
 
+	if (!pinfo->num_domains)
+		return -EINVAL;
+
 	pinfo->dom_info = devm_kcalloc(ph->dev, pinfo->num_domains,
 				       sizeof(*pinfo->dom_info), GFP_KERNEL);
 	if (!pinfo->dom_info)
-- 
2.43.0


