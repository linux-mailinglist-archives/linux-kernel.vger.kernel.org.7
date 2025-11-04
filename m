Return-Path: <linux-kernel+bounces-885568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53066C33580
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8312E464F61
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF0534844E;
	Tue,  4 Nov 2025 23:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=msa.hinet.net header.i=@msa.hinet.net header.b="ar9CICU8"
Received: from cdmsr2.hinet.net (210-65-1-144.hinet-ip.hinet.net [210.65.1.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878932DF132
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.65.1.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297626; cv=none; b=G1usVjgnjxneo4VXETcHJfo9zgtmn+2lx0iz9K/tKT+ndKuyAYyLTOJrMfuS5fty7WTkYsOjkrQPpY59T68JoS5iVuQkGChoSpJxxBURYOjyYT/cPkZTx9Q1Syz9xGfjLOHmKRfXNsD/XGpvnivz9pUTdfuAOlyMquq/eUSs9fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297626; c=relaxed/simple;
	bh=+Mx3vHHwCRKNAsvXKoEsKjYnD4VJ03pbDrpgha7ikas=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=K0+tAgoY6AYuSraS1pYjtKo5z3mLMgqlMBwD91G3g4zqkxxCTZxTUGdLHmDUfNLh5xV4BMwJvT4X6ocmWFjAzmBBhG91k5Ro7ak/djW1CBtQnuHFTyEMMsejEf5LFEAJfL6pCPTyQVPrHUWupUHxlQxoI6haGb3FamO6CmWHKZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msa.hinet.net; spf=pass smtp.mailfrom=msa.hinet.net; dkim=pass (1024-bit key) header.d=msa.hinet.net header.i=@msa.hinet.net header.b=ar9CICU8; arc=none smtp.client-ip=210.65.1.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msa.hinet.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msa.hinet.net
Received: from cmsr10.hinet.net ([10.199.216.89])
	by cdmsr2.hinet.net (8.15.2/8.15.2) with ESMTPS id 5A4N6x83822779
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 07:07:01 +0800
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=msa.hinet.net;
	s=default; t=1762297621; bh=sbYf4+NyYOsX2v1v7+F07qRXsTw=;
	h=From:To:Subject:Date;
	b=ar9CICU8QX2za+ZdnhFv2jGWm881FUdZqNFdVOD4qil50IGH+aa0yKgsHEh9DPe4n
	 eKiK1K9MkmJ1oh6wHIw3omwhBCOzmVF52GnfJxNtR0htEZWRPPvlOsQYPTdth/cA/W
	 l/CRb6N8GTjTHwjYOcu2jlKmYb6cFYyIgRQ2WFmU=
Received: from [127.0.0.1] (118-166-161-139.dynamic-ip.hinet.net [118.166.161.139])
	by cmsr10.hinet.net (8.15.2/8.15.2) with ESMTPS id 5A4N0Lvj737286
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 07:03:41 +0800
From: Procurement 21098 <Linux-kernel@msa.hinet.net>
To: linux-kernel@vger.kernel.org
Reply-To: Procurement <purchase@pathnsithu.com>
Subject: =?UTF-8?B?TkVXIFBPIDk4NjExIFdlZG5lc2RheSwgTm92ZW1iZXIgNSwgMjAyNSBhdCAxMjowMzozOSBBTQ==?=
Message-ID: <216a440c-7094-d81d-0480-0f8005c57d2b@msa.hinet.net>
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Nov 2025 23:03:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=KqTu2nWN c=1 sm=1 tr=0 ts=690a864e
	a=2MdWEo0NGJqKQNlyjv6/Mg==:117 a=IkcTkHD0fZMA:10 a=5KLPUuaC_9wA:10
	a=DzOKOi12GxIKdhb33lMA:9 a=QEXdDO2ut3YA:10

Hi Linux-kernel,

Please provide a quote for your products:

Include:
1.Pricing (per unit)
2.Delivery cost & timeline
3.Quote expiry date

Deadline: October

Thanks!

Danny Peddinti

Noble alliance trade

