Return-Path: <linux-kernel+bounces-786005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE51B3536B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458A417A79F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C368C2EFD9B;
	Tue, 26 Aug 2025 05:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OCZe3bDn"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF342E54A9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186572; cv=none; b=iUFeF1IkV3KOqHdQMOcoVcOQrDFm0nbIpmgGEEVEk83su12orXTA+/2MKldmkgG8lp7wxBgVvlnA3is1G0+XB8fwlmMaDea/0P5N3gwUhmmlANr2odBSnbiefpLoy2mO4cx+Bi+21JMIe1uBtyjNvdcxg8NOm8MDihumA4N22ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186572; c=relaxed/simple;
	bh=Vc8HqLk1oNkBJVvIOq+E2XUgPQ4z9TxRdkU64UpWBIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/TLwdN0QKS6XpEIiwV452RxZ4H0vnBuLRMYDGnl4tXUgXNyQ8HqB11sewvdapBKfhxbxRa3ykplHHNImJef9O9HGzP2ULLZFdcjuSizXFcVEbd2eRwQM8pNVNxqWM7H5d/SKakR86FbqEYeZ9z7CUuzHp3kbCY/hrCJpbDGjkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OCZe3bDn; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47174c8e45so5076011a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756186569; x=1756791369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+T8E42RqnU9AlmkM6EHxWJjzsznN4WvgoYoMrFYbi0w=;
        b=OCZe3bDneGBpEZ6VDbisda62W5hTC6i4U/27+v+8qx67MI5qdfNlloEr8QF4XGZ9ua
         /SZY6tnaifxaLsUuYUCZDjH0x4opJ8hzF+/HgcpPzbc/UCU7iyWv4SUGPYN+W47WqU6b
         vsH2uKvYlwsHDrJahQEyzoDWNFeUGWRKdntYoDlMlJx7AwipCuJ5dk7p3gNT0xGScDEk
         q1aD0oBeOw4KurRQ6jsuX91ZRB+1e8LNiK2f+hO9/Zw03e/IzhpQQ/MwkuXFu1v03gwh
         hE7sXeThdVaqpMuXZM3jypg9W2XejQBIaddpRn8BjE2g4IKiJJcLEmfL40w7OfEg7XRm
         uPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756186569; x=1756791369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+T8E42RqnU9AlmkM6EHxWJjzsznN4WvgoYoMrFYbi0w=;
        b=BuU45pFI+htTiW6RgsAF44VPGle1yyDfK90b+UQ6QISmZOwE7BrbBIyYb3zn12ztdp
         i+8pgWmz6JDixhZM9MCNpHot+fpJv/qieDiwyDPGpIbt+xsYgotTceCQZCyh8Pu/RKND
         BMhGuWwXfznb1kAdBBOpinI24R6zv21uip004RbulU7w5PpIIgbJew2oiaVi84a0bOO2
         18921GRCFcEkKyeS7m3zG1eRLJmtq0J1YU1OUKaiM8lUpYZb/02D4f5WVRm/9/oIOw/K
         TaBdD2RVL62TJDp31xXhoigE+xP1S4vcLlcd77NWXLgP7hf8ww7nuP6R99F6GaVYFr6t
         1t4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYesoQwx2wm0R8YyGgdGObDSEhAh4xCdgK0YPcAo/kmlTZoML3Wn7BbwsJgnZ0oIH9wxuwX1+9IukLi5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJVcRrIAXebhaN9NdZbr9aGqkbcxP4q1bzzYXKfUQZadZ5bNR
	FE8Ik28xWIrTsXYcW4F7Hfh+Fuk6gXzsFkhm/+eP3SHyKSLPpbsow2Ue/EI5JSSafoQ=
X-Gm-Gg: ASbGncv7Q3l5D6zOSu8PIQ9l/jnoscRuWDl/wNkjIAtLOAmppYFmeGio7TYZs5lLWC5
	7fks7CObkq+qwzigaYUqt3OK5ipkRRJ1wNkas9r2mq9JVg/YyiuDAMJ2ZFh0Em5CXxmeHsa0e+8
	Xt5grp/9JZHgUf9NOG2BVbEZeWMpiMQI8a/nTzoZ6OnN/j25WczltostMhDpQZ1GmTmmL93HXuq
	3nHriJ3EhQ8sD+F5e/UDaT77VQqFzWYDnux3qrRtxD5SvjZiwkMIW0Z3xMI9QWhOMiwe0B+aXjR
	6feN5CoLnOKokj4V3VpuBbtnGuZsXd1H6buOvihyQE96YMjCwAfzPdWBh0+GUf6S9dAsJMGbTrz
	xsNFJ0Stsrg3o3JLHmYqWId8oA5ui6aYGs08=
X-Google-Smtp-Source: AGHT+IGfTwYFjftBJaGFXjmow3/nCWDDyflG6zroy2YezNtKf+oppQf+YsobL05QgCGAZlmQXU0dtw==
X-Received: by 2002:a17:902:c408:b0:240:2281:bd0e with SMTP id d9443c01a7336-2462edecaa4mr206705865ad.2.1756186569430;
        Mon, 25 Aug 2025 22:36:09 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246ed91ee20sm32288035ad.136.2025.08.25.22.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 22:36:08 -0700 (PDT)
Date: Tue, 26 Aug 2025 11:06:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/7] OPP: Add support to find OPP for a set of keys
Message-ID: <20250826053606.zktmwgfdwymizv6k@vireshk-i7>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
 <aKyS0RGZX4bxbjDj@hu-wasimn-hyd.qualcomm.com>
 <20250826052057.lkfvc5njhape56me@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826052057.lkfvc5njhape56me@vireshk-i7>

On 26-08-25, 10:50, Viresh Kumar wrote:
> On 25-08-25, 22:14, Wasim Nazir wrote:
> > Kernel log:
> > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000016
> > ...
> > Call trace:
> >  _read_bw+0x0/0x10 (P)
> >  _find_key+0xb8/0x194
> >  dev_pm_opp_find_bw_floor+0x54/0x8c
> >  bwmon_intr_thread+0x84/0x284 [icc_bwmon]
> >  irq_thread_fn+0x2c/0xa8
> >  irq_thread+0x174/0x334
> >  kthread+0x134/0x208
> >  ret_from_fork+0x10/0x20
> 
> Hmm, this happened because it is possible for the `opp` to be invalid
> (error) even if `_compare_floor()` returned true, if the target key is
> lower than the lowest freq of the table.
> 
> Dropped the patch for now anyway.

Can you help me testing this over your failing branch please ?

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 81fb7dd7f323..5b24255733b5 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -554,10 +554,10 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
        list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
                if (temp_opp->available == available) {
                        if (compare(&opp, temp_opp, read(temp_opp, index), *key)) {
-                               *key = read(opp, index);
-
-                               /* Increment the reference count of OPP */
-                               dev_pm_opp_get(opp);
+                               if (!IS_ERR(opp)) {
+                                       *key = read(opp, index);
+                                       dev_pm_opp_get(opp);
+                               }
                                break;
                        }
                }

-- 
viresh

