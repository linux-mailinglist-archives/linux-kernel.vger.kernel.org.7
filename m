Return-Path: <linux-kernel+bounces-776919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311F7B2D2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58D37240FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F0084D02;
	Wed, 20 Aug 2025 04:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="TouYaUaR"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC924C07A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755664203; cv=none; b=k9VjJ8x8HofHSyMmbY/jRym+2KBrZuu6zDsD4qxNw3NvDdiJh7sQo5zHnIze/qYOvkxDm4X+7vfQ2l/SBMm7UwI9qzcEgjugYW5iKT1/3VREvr/nPQbUtJh1t/l3uIlq0Jzyx9nEkoJ58zN7fYwLLIag8HCVc2R4u/f6vHkp0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755664203; c=relaxed/simple;
	bh=j7GdqpbRQnKiL+YA5c1CqZDhaW9qk+RTqb/XOZKLv+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b5a9qjs0ivW4uqRTUfLeBX3YI06B0NCfYNXpJHiblZuwQMzM+UgOlkrRg9d+pHt2C4uVXpvHP5s6doootRJCl9lMS8KQUbpbkcZuGdwOBvzjgjcb+vzGAa3rEytvF773B99QRbGfeX6ZWFxwqTPswiHwFTqJnNf+wmJxG6Kam1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=TouYaUaR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2e613e90so4435069b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755664201; x=1756269001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/XhOpQfSquhT6qAiE/Hm7UDJfbQoL+JBQv5VOGD3m8=;
        b=TouYaUaRQw2+IQv4ajv2cwG1X+qf6fNruB0BJ0QmQlxONp5/E6oEqE8GmxdKxetHWC
         TtFZcaqEPWZ6kNKw6lKS7w73Qm6XslRnbpkWNRUVsab3p46ViCI1BIhiSDUd8IYbfrDc
         NDyBDvJyFaef7S3W0FfPEIxDnURmG9iqCgnrtPI6TbJ889rlnUM6+KRRfaRW2Yj6Dt3A
         SSzqhyDTEK4L+HCGEicI0epA0QJD4RBJmq6jAF22VWI01DB3kQyWM1C+vr4nWIlFVsQR
         xdiJ0tX08L/DdigYhwGBVgvfi8Gbuy2x7tA9KVve3MyuY4DRMO3rxaRBTN8WNC5bj8Vk
         RK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755664201; x=1756269001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/XhOpQfSquhT6qAiE/Hm7UDJfbQoL+JBQv5VOGD3m8=;
        b=hWxYoIczXfL73Q/+usCBDTpA9H09O59C4dsE0+Vi4WPqpjRtUiPd4O2Ak9X6H2TyR7
         HPa599vKoaakNlJPlZhOBzhtey7JO4EqMoDX9iXaXDogwt9orTINgwU9tBWzKAo/mwOb
         E4SIUOciXKz+xGFsgEIRLJUMJ4yAP6EscWcKBqdQBt01EUZNu2ykho9/gb9FMh2+XTJd
         Ark14aiPQcq12zq0PD0NDAu9r8FoTkLIG/pwovRpVd8wlUQiPSIKqMM/ChnNo77T2IsJ
         drlZrxtfVTY/6XaykcNRYYBM47izhlHC6rv272WYMSMJ0oM89EWp1sX+rPKVEaxy9d+R
         k22A==
X-Forwarded-Encrypted: i=1; AJvYcCWJLnIGGV5ygl/ynIrsG4CXVI5WpfRsvqyL86gaVzpXp4Sp/wzPQc+2ksnb7e8KbyLW4wZ9lkLJMToHatQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwG2zci1+AZAgZhsseRpeyFIc0R+AGyQlEMUHER2QOCNatMMlZ
	0POsRirsLGoa/p+Eit/DqqMAvJ82ljD9Mx0/OkQumhS43M4Ck/m6TygQTEsGHoZTO5Q=
X-Gm-Gg: ASbGncuXJTRMCZvEq/M3lh0FlAdXzL0/5mQmzn2iHOTA0eP6YgYDVlv/uKx77r4v9jQ
	2ctOzyVY0kBMCdWI7xQppErWRCFiRilrhYLSLNiH8wQq4lCiZWZJFuuYkFc0eqTP+WbmoNfc4HS
	+INZ70tO+53GOipSvGUaZE54/X/tNc0geNmXfsvvuM4CZRj1p1dOpULVREgsjlfIjq9k9tpgkD1
	QV4NGn31ytA2Gy8O+cmfghCLacQ5zwtbwQbnpi1dL/0vAePuRlfyND+2nJ46Je8jTPZcbk7dFHK
	e3sVpsi9jgOCDQbXMdxLG6v7joN35PPRkPzkP+Dk6GaMal6FJcIBMcgV4KmuO3TBFDxnan8wCUK
	pStNt/TOCH54DCiw55tJFl7m9
X-Google-Smtp-Source: AGHT+IGZr4nlgpLI+auV0iC4Ha3LGY7jX80Pp8ALkEHgYHjKKLQHDtDDxmFwBV4EzhFfQNMUpADqwA==
X-Received: by 2002:a05:6a20:9144:b0:243:78a:82b8 with SMTP id adf61e73a8af0-2431b941d4dmr2365720637.50.1755664201106;
        Tue, 19 Aug 2025 21:30:01 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fe8aaesm1133488a12.19.2025.08.19.21.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 21:30:00 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Ivan Vecera <ivecera@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] i40e: Prevent unwanted interface name changes
Date: Tue, 19 Aug 2025 21:29:01 -0700
Message-ID: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The same naming regression which was reported in ixgbe and fixed in
commit e67a0bc3ed4f ("ixgbe: prevent from unwanted interface name
changes") still exists in i40e.

Fix i40e by setting the same flag, added in commit c5ec7f49b480
("devlink: let driver opt out of automatic phys_port_name generation").

Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/net/ethernet/intel/i40e/i40e_devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index cc4e9e2addb7..40f81e798151 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -212,6 +212,7 @@ int i40e_devlink_create_port(struct i40e_pf *pf)
 
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
 	attrs.phys.port_number = pf->hw.pf_id;
+	attrs.no_phys_port_name = 1;
 	i40e_devlink_set_switch_id(pf, &attrs.switch_id);
 	devlink_port_attrs_set(&pf->devlink_port, &attrs);
 	err = devlink_port_register(devlink, &pf->devlink_port, pf->hw.pf_id);
-- 
2.47.2


