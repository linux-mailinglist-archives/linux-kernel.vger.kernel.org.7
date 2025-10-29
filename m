Return-Path: <linux-kernel+bounces-877138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF3CC1D4A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A242402195
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919B230DEBF;
	Wed, 29 Oct 2025 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XI8NuLpL"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF52EE272
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771044; cv=none; b=VtBpgO/62dIySAENV6pYBNGPSjUFS+sUfmQoEvLUl0N6kRoJUb9RjO+D+A9yn7cDXhMFV1L7z/2zxSi11qK6UjCroWxmPJ5MpzRerOn0UI8NilBkq5pnmLHUAfD8jxZdfDuXEyRcfnY8Dj4f/c4H7AeqZow4Ebz6so/4xCiQMxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771044; c=relaxed/simple;
	bh=6zjWDKHvDUmCspfnhUpUidENGOH1u4Q7Al0J9CBMnyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Cxgm6AZr35pzE50MlcFrRMEOA+z+nxfIluKEt2DgFnlQS4Wnr0eNhzvj1NKNhHlXbpQ7BqLaZ79scOkc8ECiLc3ZLWKFnKQqo2WB+MZANs+QQN5oz4e3QExacuguhU6b7kmxbpYY0ZGillzHzsZJT+r2NlMYq2LkaCsexKWknkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XI8NuLpL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42992e68ea3so44721f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761771041; x=1762375841; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QhItZvJg11h14RqD8DEUafH4SOcvlIckRX4IB4jy1L4=;
        b=XI8NuLpLMLtEHd1v6jOs/Xn65v1qzCSkyduXna5NyAOEMV2MUSdgrA7FZ2yf99NJ+L
         Cg6wWp2critoCEpOGrsEIOXUNY5pg8D18lxMh8Kbf/hp0InIFopGWw22y3sdrRSjtonl
         1UFTzmzq3LHwjIt4LbbZwBTWMbeR61rDOOq1Gdu0W23lhxOlLIGUFW4IxDhZQ3f2FiTp
         Vjt8KO87WXLRdp1Pre966wgZoXCaDVDVWwOcZhimGrA+8NHDY586ajoE5HlAY3tu9Zy+
         SoIKY+15ICHdi179rYLfo99ENKogyEetvi05kqa+MhlJiSrPsviYBoGGWJ7fgTZNcPfm
         N4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761771041; x=1762375841;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhItZvJg11h14RqD8DEUafH4SOcvlIckRX4IB4jy1L4=;
        b=OIuGiZT49aSacNdkP5qCUIADKiAJrlT+diySIqza4+3zbctYSoXWKFJHr+LRL5kW1G
         +sF4O/tvkotGAFK2flmQdQ64ZMQ5TjqanaUfm7U9++WRBuA12s2gD+DFYu4RPrt+z2Jk
         HLz9dJVl6oUfz6KcstJQxgjgjWZdw0ZSPs1GrodiFvNx4LTXZVboY39DEwFTkTXpSMJP
         q67GlcSvwBi8YJOwLKZTEUlOWqlyeRFGXqr2K7sp/POkoftijwMxMdv0qB6JxNnoi133
         gyUc6FzA2YyWWmzgti6cdxFWn4algxQQ2zVbJhl3hVpIoZi+mmyangvL8XNZRPhE9+8c
         ITTw==
X-Forwarded-Encrypted: i=1; AJvYcCUjhd6TKisid60ArTIwTUMYPplsbxZcExD307IYlCdJ8YDFs4gFPqGwmszfrzKNChgBqM6CCG2HHpkVNyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH0EVspOPgf0dFTbEGpU+WIOjDvJmWY2+pX6qF3ZnRGBkELO2t
	SIwLADahXKcAZCCw6/2vcmvQwBMLKsGvd921oEs+ynYHj/UPZC+gEXr8
X-Gm-Gg: ASbGnctVdyhI7jui06tlP0MbE1/glkCdJRAw8SeJWToX2y9Zo1b3f1Zm00TWnNNtlmk
	QpsoJ55ophqZzMXrPm9hp3DlEJfT9ZVMhNTg0S48huIifJxPEEa1I6RFA3FvSLWwR2B4w16ye/i
	F+OwuXkeMn9LgtvSFonaVtWaolzeoUI4aNYgaxq06dJGCQdbNvz3OU+UUh7S+9gRRFVoLjQKx2+
	1HBmeGipt624xrYH0WpZHro0o2xJRjzf+K2TdwbHmjG5Ee6iHWfYWZP7H6IOUiRzhTWuEbnz+g7
	dZW4dn4XnkPNd8NtRY6sDwSb2un6mmTYs/wzkrmjEFveFQRiSg0R8ocTN8ziVcnxpCv1VfZCCp9
	DHptdyCvPkasDhZlhdRsFZMQCSGI9dxGq/8eqKPhxXOyLWztXU8Zhpsvm5tzXF0n7rUHqnpWCTf
	3jgq4=
X-Google-Smtp-Source: AGHT+IFNSHCKQVaEkNNF6OQaV8zGl5KuFF0WiI/XF0XmsBzjv3pnZsHeYY3KYhcSA/ruRUVTWFvagw==
X-Received: by 2002:a05:6000:2088:b0:3ee:1125:fb68 with SMTP id ffacd0b85a97d-429aef70b89mr2039673f8f.2.1761771040974;
        Wed, 29 Oct 2025 13:50:40 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:8::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b79absm27775131f8f.3.2025.10.29.13.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 13:50:40 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 29 Oct 2025 13:50:24 -0700
Subject: [PATCH net] netconsole: Acquire su_mutex before navigating configs
 hierarchy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-netconsole-fix-warn-v1-1-0d0dd4622f48@gmail.com>
X-B4-Tracking: v=1; b=H4sIAA9+AmkC/x2MywoCMQwAf6XkbKANPqq/Ih5KN9WApNLKrlD67
 4Y9DsPMgM5NuMPNDWi8SpeqBuHgIL+SPhllMQbydAqeIip/c9Ve34xFfrilpphj8bnQ9UiXM1j
 5aWxuv97BAnjM+Qc58uNzagAAAA==
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthew Wood <thepacketgeek@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

There is a race between operations that iterate over the userdata
cg_children list and concurrent add/remove of userdata items through
configfs. The update_userdata() function iterates over the
nt->userdata_group.cg_children list, and count_extradata_entries() also
iterates over this same list to count nodes.

Quoting from Documentation/filesystems/configfs.rst:
> A subsystem can navigate the cg_children list and the ci_parent pointer
> to see the tree created by the subsystem.  This can race with configfs'
> management of the hierarchy, so configfs uses the subsystem mutex to
> protect modifications.  Whenever a subsystem wants to navigate the
> hierarchy, it must do so under the protection of the subsystem
> mutex.

Without proper locking, if a userdata item is added or removed
concurrently while these functions are iterating, the list can be
accessed in an inconsistent state. For example, the list_for_each() loop
can reach a node that is being removed from the list by list_del_init()
which sets the nodes' .next pointer to point to itself, so the loop will
never end (or reach the WARN_ON_ONCE in update_userdata() ).

Fix this by holding the configfs subsystem mutex (su_mutex) during all
operations that iterate over cg_children.
This includes:
- userdatum_value_store() which calls update_userdata() to iterate over
  cg_children
- All sysdata_*_enabled_store() functions which call
  count_extradata_entries() to iterate over cg_children

The su_mutex must be acquired before dynamic_netconsole_mutex to avoid
potential lock ordering issues, as configfs operations may already hold
su_mutex when calling into our code.

Fixes: df03f830d099 ("net: netconsole: cache userdata formatted string in netconsole_target")
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 194570443493..9e17632e0bc6 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -931,6 +931,7 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 	if (count > MAX_EXTRADATA_VALUE_LEN)
 		return -EMSGSIZE;
 
+	mutex_lock(&netconsole_subsys.su_mutex);
 	mutex_lock(&dynamic_netconsole_mutex);
 
 	ret = strscpy(udm->value, buf, sizeof(udm->value));
@@ -944,6 +945,7 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 	ret = count;
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
+	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
 }
 
@@ -969,6 +971,7 @@ static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
 	if (ret)
 		return ret;
 
+	mutex_lock(&netconsole_subsys.su_mutex);
 	mutex_lock(&dynamic_netconsole_mutex);
 	curr = !!(nt->sysdata_fields & SYSDATA_MSGID);
 	if (msgid_enabled == curr)
@@ -989,6 +992,7 @@ static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
 	ret = strnlen(buf, count);
 unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
+	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
 }
 
@@ -1003,6 +1007,7 @@ static ssize_t sysdata_release_enabled_store(struct config_item *item,
 	if (ret)
 		return ret;
 
+	mutex_lock(&netconsole_subsys.su_mutex);
 	mutex_lock(&dynamic_netconsole_mutex);
 	curr = !!(nt->sysdata_fields & SYSDATA_RELEASE);
 	if (release_enabled == curr)
@@ -1023,6 +1028,7 @@ static ssize_t sysdata_release_enabled_store(struct config_item *item,
 	ret = strnlen(buf, count);
 unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
+	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
 }
 
@@ -1037,6 +1043,7 @@ static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
 	if (ret)
 		return ret;
 
+	mutex_lock(&netconsole_subsys.su_mutex);
 	mutex_lock(&dynamic_netconsole_mutex);
 	curr = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
 	if (taskname_enabled == curr)
@@ -1057,6 +1064,7 @@ static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
 	ret = strnlen(buf, count);
 unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
+	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
 }
 
@@ -1072,6 +1080,7 @@ static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
 	if (ret)
 		return ret;
 
+	mutex_lock(&netconsole_subsys.su_mutex);
 	mutex_lock(&dynamic_netconsole_mutex);
 	curr = !!(nt->sysdata_fields & SYSDATA_CPU_NR);
 	if (cpu_nr_enabled == curr)
@@ -1100,6 +1109,7 @@ static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
 	ret = strnlen(buf, count);
 unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
+	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
 }
 

---
base-commit: 210b35d6a7ea415494ce75490c4b43b4e717d935
change-id: 20251028-netconsole-fix-warn-c8f0cf294276

Best regards,
-- 
Gustavo Luiz Duarte <gustavold@gmail.com>


