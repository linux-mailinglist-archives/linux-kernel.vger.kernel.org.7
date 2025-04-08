Return-Path: <linux-kernel+bounces-594416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31068A8119D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 18:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB21189DA1B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179BF23BFBC;
	Tue,  8 Apr 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OrAdb8Gi"
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D399C2397B9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 15:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127928; cv=none; b=IWwPfFdM+fG6nnN7k86DH3kl8UWLFBaguLtUjYPQwgxHXfDNlZRdD8DCtvWr/cViI/gpER/qpK8jpCJlTGKymz3hWy70KO4qwOsVoCdTPX3h8S1UxSCL+mtM3mcA3vmg8T3DJFdN9uRK6kbbAZ2CRp303QI2ZdQ8y5cbVxsLycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127928; c=relaxed/simple;
	bh=RWDIxjKULERd9rKieT1KlSktqFsibzwWfqHPe/4cIa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References; b=p0/HGwXt2bAsLnAoBK8kqH7jyOh3ifd8r6bEGhp22YikviMQ9q5DQacvBnsBc/BPdaNQ01VzcRKwfTksWnNctvOFm4AvbryMO0vV8AaLZYxLflgA71R0zRUDQIStMIUcvqkPh6r7dV93mrtTAIexv0JnczCwPiwzMDe41z/lq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=OrAdb8Gi; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso465017339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 08:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127926; x=1744732726;
        h=content-transfer-encoding:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaVO28FUsf/+j+eVB0JXUktqw+0W3V93Ws76bANlpTw=;
        b=VFHySj0bNuFcExcGcGKi+13WJbJdp1m9IBee/aeHxrdwDoydMneu1AZeFtNOUnrfhl
         pu3N0OIP+QUigliKaQZnGmV+/sD4jbAzKg08OcOPUwQhNe4Jaf9x2n10KtqijR2kH51J
         /cGkh+MGt3v/ZsIZ3JfraLOAMA+0c/W22wihyYjyHWctPy9LUcYw0Bi/V8hvlsYkSAg9
         nd89aAg9Gg7JTekll25ilFHOynvXsb3dmivllytNdyh90xcejnf0jBD1PWE+bHttTh1m
         A0vneXxy4q4k3SWvb8TEfRAxOMb8cg8DFKL8PwUYAFq9FC0hKYRU7qphDc0Tpz6pMWy2
         E+/g==
X-Forwarded-Encrypted: i=1; AJvYcCXuXhKLPq/vWU0ix86pbJvHas3R68MhJkEVEgG5BUd0ZlAuPB9T0YfbidHSSggNTQjNAJq7hcUn+AbshD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzds0z3w8r80POEwuZLlhpySoVfZhyT2qg71K8M8MY8W0WPQvMu
	6M8h/AjLDMSxr/o/Cyi5bIHNKGDI3WmLpyfppk7BPtbsdB4Kg3NpcfATU95fFyzP1qOAllNJc0H
	pmn9M1aB773OhJGEfWYuSCq1m/Nsm9Q==
X-Gm-Gg: ASbGnctgzEW18K92+IF9mcAFnCzRAfagbJAMD2Yvn2AOcebXzBNshJEE4Y7jLZUAd1I
	xNy4SNoaEbRBiu0BG8elxfLciJes+PXt70XFffYg+tBfMJ7rJpccMgG6PYwl1TRRxqEX58NitE6
	7heL5tsTP49A3RV9vwk3fum/K9f2KDaQOueKDC1N7wLhShtaNdEdbwDF0OTlXIaYtsdEk3S6gwj
	Sdkbd5lir2qjIsAu8MP0R/nubLzkeoVrzM3JZCc2s16nmx6qsYz8kwEy+hZr4h5B68achMUmlvE
	/TXHjsyxIjMoJBrzT57o7wuoN6g=
X-Google-Smtp-Source: AGHT+IEUKMpwu6G2eNbCLy7G2hpZnc7p/3gu0cXPUTvBdg3n05YEdQqhBspTylBX68cRhCoAQd3hqLSwSNn3
X-Received: by 2002:a05:6e02:1aab:b0:3d4:3fed:81f7 with SMTP id e9e14a558f8ab-3d6ec594cbbmr139695615ab.19.1744127925943;
        Tue, 08 Apr 2025 08:58:45 -0700 (PDT)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d703b6c997sm1199585ab.9.2025.04.08.08.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:58:45 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1744127925;
	bh=jaVO28FUsf/+j+eVB0JXUktqw+0W3V93Ws76bANlpTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OrAdb8Gi7kK42a9cG8OQD4nUjCJBGi3FAoNaKh8E2cXUj+0b3ObrsD39TrEIr8Pgv
	 K3rGJSm2AKRAHDr+BfxIR3xB1yps+6az/gW1yk8PJR8mSi5Pe+TXE95xk3pDKPAQMD
	 QaY5pqM0eq61PLuqJvFSMbSNqIO8B2+pPCgspfh5xbH/sPQqej0dYzxBoT9uGJ/HQe
	 8+wMntox3LmSshqP+t7fxT8Ul/9wilvWW8s29wlI0+YV+dSdxnGqrSWZrd/2DZcnKS
	 eGcg+waTMhSNxsbA9DdQpV8LYrNfq5kWyXYp9iTxhWuzgoQhqsX9pUgq0Xls9nCbig
	 QCYIX+BOAtxCg==
Received: from mpazdan-home-zvfkk.localdomain (dhcp-244-168-54.sjc.aristanetworks.com [10.244.168.54])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 0C1B610023B;
	Tue,  8 Apr 2025 15:58:45 +0000 (UTC)
Received: by mpazdan-home-zvfkk.localdomain (Postfix, from userid 91835)
	id 0560440B1D; Tue,  8 Apr 2025 15:58:45 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Marek Pazdan <mpazdan@arista.com>
To: kory.maincent@bootlin.com
Cc: aleksander.lobakin@intel.com,
	almasrymina@google.com,
	andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	ecree.xilinx@gmail.com,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	jianbol@nvidia.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mpazdan@arista.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	willemb@google.com
Subject: Re: [Intel-wired-lan] [PATCH 1/2] ethtool: transceiver reset and presence pin control
Date: Tue,  8 Apr 2025 15:54:14 +0000
Message-ID: <20250408155844.30790-1-mpazdan@arista.com>
In-Reply-To: <20250407153203.0a3037d7@kmaincent-XPS-13-7390>
References: <20250407153203.0a3037d7@kmaincent-XPS-13-7390>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On  Mon, 7 Apr 2025 15:32:03 +0200 Kory Maincent wrote:
> ETHTOOL_PHY_G/STUNABLE IOCTLs are targeting the PHY of the NIC but IIUC in your
> case you are targeting the reset of the QSFP module. Maybe phylink API is more
> appropriate for this feature.
> 
> You have to add net-next prefix in the subject like this [PATCH net-next 1/2]
> when you add new support to net subsystem.

Thanks for review.
From up to now replies I see that there are concerns regarding usage phy-tunable ethtool
option for this purpose, so I will post updated patches after we clarify proper way to go. 
I need to check more on phylink API, from the overview I read:
"phylink is a mechanism to support hot-pluggable networking modules directly connected
to a MAC without needing to re-initialise the adapter on hot-plug events.

phylink supports conventional phylib-based setups, fixed link setups
and SFP (Small Formfactor Pluggable) modules at present."

I don't see QSFP modules are being supported but I need to verify impact of this.
As I mentioned in other reply this API should allow for transceiver module reset 
from user space if orchestration agent detects transceiver failure state or when
it gets direct request from Cli.

