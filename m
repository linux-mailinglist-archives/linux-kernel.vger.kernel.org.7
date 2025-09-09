Return-Path: <linux-kernel+bounces-807345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E37B4A33C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB3C540141
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E8F2FE053;
	Tue,  9 Sep 2025 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="XzZSHQbc"
Received: from mail-m1973172.qiye.163.com (mail-m1973172.qiye.163.com [220.197.31.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B821BDCF;
	Tue,  9 Sep 2025 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402122; cv=none; b=VMwuLQgWrqxHdMZ4RaIuAGKDuppYB3rkodLyvDXaMX2p6J+TfmwkT2tvNiJKHanVKgAITmwFmOJA31Tv9zleYHsR+jhstAevUsQW28ziwePSWUoxz6OuDCo449pUuh0/KNQpPl7qFTdDn+HReFZ/27FlgxYi/G2RAufpNGNLKTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402122; c=relaxed/simple;
	bh=wC2YdjaoJqa6I6tZoopLuKkVfIOaaVL5SZDexHzOil0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6BLchrkCFxPtXj/UUwiK9KEBUVRhsXd75E6RrUFTJSU38Xyffhwxl90BJ1gR58VgP9zD3B84Q3sPLZdCmPFxFXYw9TQWMfAo1U72bqOddG6zM/Hvp+iT85DPdWY9Z+Ys2xxMKkR71iQ6luvLqCvgPTrI53OobvHoJEO+VmOnoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=XzZSHQbc; arc=none smtp.client-ip=220.197.31.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 222bd6686;
	Tue, 9 Sep 2025 15:09:59 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: krzk@kernel.org
Cc: adrian.hunter@intel.com,
	arnd@arndb.de,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gordon.ge@bst.ai,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	yangzh0906@thundersoft.com
Subject: Re: [PATCH v3 6/8] arm64: dts: bst: add support for Black Sesame Technologies C1200 CDCU1.0 board
Date: Tue,  9 Sep 2025 15:09:58 +0800
Message-ID: <20250909070958.2254093-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179f19c0-d9fc-4efb-bc78-8dc1e7505b13@kernel.org>
References: <179f19c0-d9fc-4efb-bc78-8dc1e7505b13@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a992d4f5a6d09cckunm2b88969717a32b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDQhlLVh1LHxlOH00fSRhKHlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XzZSHQbcF9ZJs+G5NZSq2VaVBGuGZYoNSGiWDlxe8Cwqf+CB5cB9YWCziVpWDskPmAZ7avSRJpKDGQAub291cHtmX+BNY9y9tl4tSvuYymgslhONcgfaZ+7aMbdSqqKHJmO8fzENUjWKvd5TVhRNK0vAxvCq8C67L5Qo4+hT4q4=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=WrtxNVHwTJ4oyryUvdf8ihpCH/wC7AM/4lz7xfEKLZY=;
	h=date:mime-version:subject:message-id:from;

On Fri, Sep 05, 2025 at 09:23:48AM +0200, Krzysztof Kozlowski wrote:
> On 03/09/2025 09:06, Albert Yang wrote:
> >>

> > However, I'm uncertain about how to order properties that start with "#".
> > I have treated them as standard/common properties and updated the node as follows.
> > Could you please confirm if this approach is correct?
>
> They go as standard common properties. Whether you group all '#'
> together or sort by name skipping '#' is up to you, because common style
> does not define that.
>
> >
> >
> >             gic: interrupt-controller@32800000 {
> >                     compatible = "arm,gic-v3";
> >                     reg = <0x0 0x32800000 0x0 0x10000>,
> >                           <0x0 0x32880000 0x0 0x100000>;
> >                     ranges;
> >                     #address-cells = <2>;
> >                     #interrupt-cells = <3>;
> >                     interrupt-controller;
> >                     interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
> >                     #size-cells = <2>;
>
> I would keep #size-cells after #address-cells, because they describe
> same thing - addressing of children.

Thank you for your feedback and confirmation. I will update the node 
according to your suggestions as follows:

        gic: interrupt-controller@32800000 {
            compatible = "arm,gic-v3";
            reg = <0x0 0x32800000 0x0 0x10000>,
                  <0x0 0x32880000 0x0 0x100000>;
            ranges;
            #address-cells = <2>;
            #size-cells = <2>;
            #interrupt-cells = <3>;
            interrupt-controller;
            interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
        };

Best Regards,
Albert

