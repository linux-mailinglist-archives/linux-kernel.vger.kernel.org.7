Return-Path: <linux-kernel+bounces-876829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C1FC1C783
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87663188BDB1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F3834FF6E;
	Wed, 29 Oct 2025 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6r0cFn6"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B0D346A09
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759312; cv=none; b=ZgJ3O0N1a7MqRvV8VuyoeFN29Sb/TJG8GvTYz+ECRE5AePVK8v/0dxg1mYikVYnK1UCFkub4Vhurm/YchTVIM9yInq3IIq2tZyygiXYfClevA+hD2o5WEPr/N/ovRg5wepWghNujvrXAi46P2lakYw1NLRlU8UcdOdeZ+bLDoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759312; c=relaxed/simple;
	bh=g98qGunIl/C664+ehFNVQ4SzabEgiIu2KI5IioXRSsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u7gdXfrvvq7mhx8cgXpK5Xk0o6hRCYztPkOPIDUhngs5lZ2NV6SWpYPV45N5Gwi1kixVtBiWMrPxGTKZR6Qx1CFDqQ80rCcYfKJx/H3ohyMe9ELtedSV0Uxx7T5RgVbN7FK5QSDJEl+2ERQaeyjdP0hkRUuYmoip9YSbuirBXAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6r0cFn6; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3737d0920e6so594561fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761759308; x=1762364108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XdYN/06x3KRPapdi984l0BW/Th8+IhDTjM+xhirl2Oc=;
        b=i6r0cFn6LcL7XUA0vVoFj7DnZRD6PWfrlydvSkHABX9eonsBGXmY358b4GQQYUhuaz
         XalJB7WjMFlVzPY1hecsRynsklJnG6pukgfnpxvaFMxLkzqzAMrTUUUzo6HIBJpKMv30
         rjlGFZVVPkCDqTQ6cL9GQeqqlWomPLJgFqo5qRnbAPJcMYB/ZNICiZo8/f7F9Wy/HRlI
         Rb5JVuv69c9bq43XNdy9sUajbPhHkT3t7qVCIV1VWMFP98E1kPYCwNCNGiQ9uwU21epX
         aqaHBQ/NuX1Pck9FF9YxWzldyNwc/sfKGSadhmbCQUB22BjEbVlIDcsZGGV0oBMvQWIO
         Fm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759308; x=1762364108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XdYN/06x3KRPapdi984l0BW/Th8+IhDTjM+xhirl2Oc=;
        b=aPHbKDR/73c/CSwJiQPoxy0hE1YDc2pC4Q3KuHcTGf9oicAUhqPqOXZ0YsJQzNW6Tv
         MzE6RYrc4CDzgexTCizM/jJ2qweYX96fsQq6exVCJzpydCkRV5j+ipmH0QdbPXa6C3OO
         st++399nYjU17F+siCJCFJZ1Dg805Q7BiS/6E169QfM02OIx3KXQczDHeW2fuJtoxFGT
         8JbTfWRr1zTSghoORl5/yzvObl4DK+CS37hqEyC5jBPee+pQ2ELpX2BHlvBNa1wk51kP
         PSUAAWz3wtJorAGliuVQKAD3GcV99X74lI48N/tgWXnVMH1i6tKIaLEKg7EMOnOW+s6q
         b6nA==
X-Forwarded-Encrypted: i=1; AJvYcCW+GkzALdxmo15kmhpugtd40NA2zKBvlExMY0DYlh7mN98Hr2QvXnRgY2mIugPsTKurj56QbMdXnglbaBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz96uQ7loAyfjFHaom09hvCtchh7q9UnJa5O4opu7c78f0vNge2
	iujKF0217VzlY0345w33UCFfumK8FRZ8i5d4UxPX1owKnP0diTtagenY
X-Gm-Gg: ASbGnctMudPhPdKG+a1R/cer1OFXOkKYBLp48YE52P6KfM18p4Y5lJnmieMJquhSbOW
	vGau5LokVauwtd/ojTsCNTAU8/PYd7I7K0gEJ0WPq1ux1E496wxqnR/WpH4kN81gmM6j7U1ey/w
	5eijfDJDcb7jgYxSxOHC7qSV+HsMqICEDCSQ7BJ+Rwyf+Mjj50UJkxlD6vOPa0RE84dWZl4ER2t
	xKM0V0C3TJW5dffEiUxQh07Paaks0wt1/pRx02gkwtI6kLS6/+vV7jHqhvylvCQMFlXhrXaoMkl
	b1zP6xPghIq2UxgsluJea9tB2+i67Q2d/HazDo5/XBW+RZrIEFR8ZLyG9ueWyUq4r/TO6n6N08l
	ttUmn5dBCnq0bWi1ynmWlfn1H199f2Omn1syfJe0HuwdrcFla/tu4PdvdJFT1JRdxo6Rl4pIpf/
	Gs2KtICiBpp0KeqZoBUQ==
X-Google-Smtp-Source: AGHT+IEwDLNwLK/A2+TDrXzVle4wM4y4gZurIwihWWiE7msduXVNYsAHjJg+irNLnRcqkFgHzU7XvQ==
X-Received: by 2002:a05:651c:516:b0:36b:d9d2:734c with SMTP id 38308e7fff4ca-37a023ba9demr13208061fa.8.1761759308078;
        Wed, 29 Oct 2025 10:35:08 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee091f33sm37346051fa.3.2025.10.29.10.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 10:35:07 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: a.shimko.dev@gmail.com,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scmi: reset: validate number of reset domains
Date: Wed, 29 Oct 2025 20:34:55 +0300
Message-ID: <20251029173456.1749436-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add validation to reject zero reset domains during protocol initialization.
While the SCMI specification allows zero domains, the current driver
implementation cannot handle this case safely.

The fix adds an explicit check for zero domains in
scmi_reset_protocol_init(), returning -EINVAL early during protocol
initialization. This prevents the driver from proceeding with a
non-functional state and avoids potential kernel panics in functions
like scmi_reset_domain_reset() and scmi_reset_notify_supported() that
assume dom_info is always valid.

The change is minimal and safe, affecting only the error case while
preserving all existing functionality for valid configurations. The
existing -ENOMEM handling for memory allocation remains unchanged and
sufficient.

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

Case with num_domains == 0 before the fix:
[   25.617950] SCMI Notifications RESET - drivers/firmware/arm_scmi/reset.c scmi_reset_protocol_init
				num_domains == 0
				pinfo->dom_info == 0000000000000010
[   25.623655] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
[   25.625241] Oops [#1]
[   25.625585] Modules linked in:
[   25.626343] CPU: 1 UID: 0 PID: 62 Comm: kworker/u39:0 Not tainted 6.12.0-01121-g62b3fcf44d59-dirty #1
[   25.627257] Hardware name: YMP ELCT QEMU (DT) 
[   25.628276] Workqueue: events_unbound deferred_probe_work_func
[   25.629447] epc : scmi_reset_protocol_init+0x256/0x2de
[   25.630109]  ra : scmi_reset_protocol_init+0x248/0x2de
[   25.630616] epc : ffffffff8080d618 ra : ffffffff8080d60a sp : ffffffc600263350
[   25.631232]  gp : ffffffff81a4d9d8 tp : ffffffd60e834380 t0 : 0000000000000008
[   25.631897]  t1 : ffffffffffff0000 t2 : 69746f4e20494d43 s0 : ffffffc6002633f0
[   25.632570]  s1 : 0000000000000000 a0 : 0000000000000000 a1 : 0000000000000000
[   25.633364]  a2 : ffffffd60ece0740 a3 : 0000000000000000 a4 : 0000000000000001
[   25.633950]  a5 : ffffffd60f75c640 a6 : ffffffd60e834480 a7 : 0000000000000001
[   25.634496]  s2 : ffffffd60eee3440 s3 : ffffffd60e812a30 s4 : 0000000000000010
[   25.635037]  s5 : 0000000000030000 s6 : ffffffff80000000 s7 : 0000000000000000
[   25.635581]  s8 : 0000000020000000 s9 : 0000000000000002 s10: ffffffffffffffff
[   25.636127]  s11: 0000000000000048 t3 : 00000000000000ff t4 : 0000000000000000
[   25.636660]  t5 : 0000000000000001 t6 : 0000000000000008
[   25.637071] status: 0000000200000120 badaddr: 0000000000000010 cause: 000000000000000f
[   25.637836] [<ffffffff8080d618>] scmi_reset_protocol_init+0x256/0x2de
[   25.638472] [<ffffffff80805670>] scmi_get_protocol_instance+0x186/0x44e
[   25.638984] [<ffffffff8080597c>] scmi_devres_protocol_instance_get+0x44/0x88
[   25.639501] [<ffffffff808059d2>] scmi_devm_protocol_get+0x12/0x30
[   25.639917] [<ffffffff804e3978>] scmi_reset_probe+0x3c/0xce
[   25.640278] [<ffffffff808010cc>] scmi_dev_probe+0x18/0x26
[   25.640566] [<ffffffff8058541c>] really_probe+0x8a/0x30a
[   25.640830] [<ffffffff80585700>] __driver_probe_device+0x64/0x10a
[   25.641147] [<ffffffff80585864>] driver_probe_device+0x2c/0xb2
[   25.641450] [<ffffffff8058595e>] __device_attach_driver+0x74/0xd2

If this is a working case, I will check and supplement other protocols such as
sensor and power domain.

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


