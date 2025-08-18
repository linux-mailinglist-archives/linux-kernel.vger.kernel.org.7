Return-Path: <linux-kernel+bounces-773196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B7AB29C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B1D3B0E89
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74BC302CB9;
	Mon, 18 Aug 2025 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbOaJ38A"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E75308F10;
	Mon, 18 Aug 2025 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506654; cv=none; b=bNDT34RfNVmVppXw2FpIx43tc1Xa9E7xMTw8dfOlCQZO04ciY4CO9bKy6C5CAdCX1utEDpFhi71LvHsKNs2Wvoecdx+/qs4yhjR5QjaEOa0k1qOfX3xn8Llhu8uNV/J6rhVi+yD3jMgvPcsdUOK78mpH1cVWdx1a1ugAqQA+iWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506654; c=relaxed/simple;
	bh=pTUWkvNCIyhLcProl9XhpfAEq16p+fwv6rNm58M87Cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GfA/C6Fv6nuQxwmHgQY0DE+omakhxRkpDyHuojMQer9HVFXZnWhrSxehUqt5cbFxS2k9t9bap1slmTykkCeqYCBU8dfo8oHLUe+SmV3fJkxU9CJvdVp96uBIfPH/VONTbMEh4y3ypRH5r5WbAm4ogzD6+eQGZcF1pEbnvWRN+4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbOaJ38A; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b472fd93b4aso2160044a12.0;
        Mon, 18 Aug 2025 01:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506652; x=1756111452; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=UbOaJ38AjWrsPJoW75D3eb2Ot5i/GdO9v8IctLlf/aBwOHiqJl2qhJxhGsp+ztnNqz
         z9i+AMPbRUJHbYM6SGQ/Ly3kX5k8+XyWgnltcv4IEUcQUQWIItBAZA9iE1qYhPL456Ts
         74jITXuyNJAZK7VupzXdTEMwHwMYyCcQTcn5syxuJH7yLOHGvPAeAEDJMmjTR8oti2Fk
         L3sIZbuQ6LJFDoUL/lqKS4+jM3Hbqm7P/1pnc3fNiQcRaQ0No5FrNrxuNEbsSI+5DwNL
         3HV9AGyeP3GISp9tzQK3E9Vg6yyP0gKanacO0mYQFc2WfSkXjwYeiF86qMlKLme8RBth
         5YBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506652; x=1756111452;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jrUSLF8HrmgX2IqYpc6hu8jyDWmvx8chNYfkelzvuE=;
        b=orzW5NXYyLu/ck2YHV2eogqQEgQoGejXftP/R3gHJgJeKSgCr2aA20GVewEwJI5Jwu
         TfoNDToSMZGvnJaBwmM/chUx6b9h4lyjYgERb0nIsrbBa92BbHeRARdnMRILjfpzxIEe
         3aCYlL2r7vtaqgjBsI9InIm0w3LAAWLTasP0ssNN+A6QbLKwidkKWC8nN4AUHOfCoCTZ
         5N7lvuZ07OnFTIRG5P3c+wXbn5xMWViolwZQlXiHw99zccpCtC2qpAFzXEkMgWGh7StY
         N7aoQFjr/pPkZkupwQwfbc9611tvObr5lTOUmbqoQpfnUQG3CWTKVLJvWLxFf6p4WYfy
         jfAg==
X-Forwarded-Encrypted: i=1; AJvYcCVMwqhmHIOH77xnf2tBQy9/9TeOuumlLnx04upSs9e6r3nlg7lW1TC2bhJVpM6tka99X0kQr8BFcOgEJXEx@vger.kernel.org, AJvYcCVQO2F/GwEf+uuFybj8FVawEJI1E16F3hceBpdkM4EGP1NB3BzVYrZBtVgOJt5nC/Wn7HN579wDcYrS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/Ngvdj3727BV3YZI/0wBzocXTcNzT6Rg1aw6QC7XJSoYqGcV
	mM3dUisejwK/vCLUbXz9vBkPg6WfVQzl2voSK1w7zxIJHJ6M0Wx4B80I
X-Gm-Gg: ASbGncsFC3t7IxDvfAe3KkAN1EKLQrLw532brfEeg4P4Q3oWbPQW/x1hKoedY96T60L
	SoSGH9szNz28aa4BaU5MO2EsGvF+jFm6FLlS4deyc7a835W0N/L4AbD7pnQUu+/D6/Bd2uJqCPp
	HZqcLJe2t+j19qzPv/A3gMqhn0oTMMfrZQfP+sjZdvVkDrpklpXZKNHEWodDYDiaUfDtxV3OQXZ
	gm/9Qr8KFcWbcsCK22KvvvydoU84J8OY7ZNDBig9HtAug8d928IafNXdjmEvw6QsCM7hfsAG3QY
	/njFFvqy4SeWscp3kPUL8Ft6C6tQbgPsp0CkEpSpcVR79v/klDuWkJm8ll9zXZFA9hciYNz/DBh
	pb8m6mjcsQ/ndx8egnR3WcbXFJgn7GjjRCkiZYAuUq0b337vLQbgxK5MhJw==
X-Google-Smtp-Source: AGHT+IG1afPtfSsM25RsLVziBfnzCxe+fm/mDBbqheQlT6OGm2ccgvPEYnJThK+OOSerwaXiksOffA==
X-Received: by 2002:a17:903:24e:b0:240:8704:fb9 with SMTP id d9443c01a7336-2446d948463mr151270825ad.53.1755506651863;
        Mon, 18 Aug 2025 01:44:11 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:44:11 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:43:01 +0800
Subject: [PATCH v2 8/9] arm64: dts: apple: t8015: Fix PCIE power domains
 dependencies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-8-65648cd189e0@gmail.com>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
In-Reply-To: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=798; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=pTUWkvNCIyhLcProl9XhpfAEq16p+fwv6rNm58M87Cc=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouelWWJ0YeXG6dIWCt0vJagWW33XZSkjmaJ2r
 35WAX3kwK6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JDvPEACrtXL7Qr/DBRGiWukhhjd/4Z4w2dKfoWc6FF9aC19lals0kztGvk/RjEmsDol5RmPErQE
 MIEd5GstMiWFW32+K6f1VMh4YNf6wUn2kaz1gexAQdk0XAYgAsiKV3AUMPZrN37GpzqBoyCht0M
 kFxcpnvdq6CBkOsu8pgnCTRBe8PLDtGJPMcV33U5PlJXfpgJYRRRhaZKgBK6NebPt7m/09uodgd
 Oc5veSeMzd3QzmVqI5AkGn95VcnN0lWiA5srfxz6RhhoOk/ixgyTvg2IreLOKLzDMXlhzmA9Xpn
 mochAQmxFSZ3ZF0znN91qZH8HrC3zNSpEvDN9RQ8YnIaVg2n2plKKlIha5CRG4PNKfwzbJw3J6+
 3ClQcpUcYudBkeCcyPzqczIqMPpQ5tz6aL1MolfiiV2Yt2dRCIuVPvoEZbhNKDaYuDej1nGXJW7
 EygOsTIebFypwkjFkEDvwnjjbsnMRO/I67936jtrsqXndRUbb+srPh4kGIRsmP6QUP3F1zTnIgU
 nWY75uqHxdfv/jJ0deQ0nY+wLSX/iH0bW3ZHz50//N0JRxxBpkObWScmPh3d6+w306mkpnXriD1
 fzSAYuwHgXJI6yMrpyZVw2p2KBkOdbiUiNvJ/rMIBgEAKGDQUu3Ytqp9c9Xe2on8hUxHM96fmSF
 DaIl4kv/gDmUEOg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Fix the dependency topology of PCIE power domain nodes, as required by ANS2
NVME controller.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
index e238c2d2732f7944dc1f984a4eb647ba212b9ea5..1d8da9c7863e5b7a732888342de9d481f309edd8 100644
--- a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
@@ -658,6 +658,7 @@ ps_pcie: power-controller@80318 {
 		#power-domain-cells = <0>;
 		#reset-cells = <0>;
 		label = "pcie";
+		power-domains = <&ps_pcie_aux>, <&ps_pcie_direct>, <&ps_pcie_ref>;
 	};
 
 	ps_pcie_aux: power-controller@80320 {

-- 
2.50.1


