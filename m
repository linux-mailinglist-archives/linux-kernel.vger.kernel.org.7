Return-Path: <linux-kernel+bounces-780982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C058BB30BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CF4602A88
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 02:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E591A2C0B;
	Fri, 22 Aug 2025 02:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b="u07qho9v"
Received: from va-1-20.ptr.blmpb.com (va-1-20.ptr.blmpb.com [209.127.230.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9046A140E5F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830239; cv=none; b=VmjHXe1KPc2w0xYYs8wjJxN3vRn6mYoeQFtcw5WdwcgLayUcDRzu05MWeojz1WbqmoE3iE0r6E5EbNAj5qQqFzv7k6lnNo9z6WKFKK0Me96mNxR3djOZFtJ47AxXVrxb+VNdM+IyjlshCImUrdX4d9x7VitXUpgSMpQmnmfz4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830239; c=relaxed/simple;
	bh=OX0qQeafF4TgTCcyrgXJILtED4m/Hr6OfWXNy/L2kuU=;
	h=To:Subject:Mime-Version:Cc:From:In-Reply-To:Message-Id:Date:
	 References:Content-Type; b=b7j3NLgAfyBQp/BtbE6QuFYYXRByxRAqvFHCZJdCMDKG5lvCGKaB7rRYW4Bxsp5GPdg18Vnphtd2Buw9XgF4APs19JMP+Hhr/eDgZdIw7JR668xRgA1HD0B5aRveAkYqnf+1rvyjxIPmP/R9wYIhHZT7SzduMQLtGnzye+QJvE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com; spf=pass smtp.mailfrom=lanxincomputing.com; dkim=pass (2048-bit key) header.d=lanxincomputing-com.20200927.dkim.feishu.cn header.i=@lanxincomputing-com.20200927.dkim.feishu.cn header.b=u07qho9v; arc=none smtp.client-ip=209.127.230.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lanxincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lanxincomputing.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1755830183;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=wM2Pu7ubOLQjp3YGifNjivB5Nz4a+TlbNw/xHfw3RnM=;
 b=u07qho9vrBAHyq3bmONyU1L7dFC0wt/CFQatDkY2RZj1y+tTdEbjSmlcqa5VhR4HzZt50c
 1XPrvSXvluKmqefRmmu0LioJHxFCN3GZxVNQJbMTUGKvQZyknLxZIvRzX19Fu9jwgujRp7
 MUHD7eRgDzYX4FP5rkiDPecQNrtjLrMKl0ovX2VUXBx/Q6HMlS0V3kGjFj0a5VmrWgGUKJ
 MQkxUGJYep/mkeAHbd7knSn0j+sVzr40TH6k8LFqSzL5LWn9zZSuB14oGjbAVUrFgTZ3Fw
 55c2Il7IudNfkfa1/oVv49H8+7nEUKAK9AFD1qWzIPq7ZGE1vuvjReaa+0dk+w==
To: <markus.elfring@web.de>
Subject: Re: Re: [v4] iommu/riscv: prevent NULL deref in iova_to_phys
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Cc: <alex@ghiti.fr>, <aou@eecs.berkeley.edu>, 
	<huangxianliang@lanxincomputing.com>, <iommu@lists.linux.dev>, 
	<joro@8bytes.org>, <linux-kernel@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>, 
	<paul.walmsley@sifive.com>, <robin.murphy@arm.com>, 
	<tjeznach@rivosinc.com>, <will@kernel.org>
From: "XianLiang Huang" <huangxianliang@lanxincomputing.com>
In-Reply-To: <aed0e72a-3c98-4027-8676-b8f469d857f5@web.de>
Received: from LeonHXL.localdomain ([116.237.111.137]) by smtp.feishu.cn with ESMTPS; Fri, 22 Aug 2025 10:36:20 +0800
X-Original-From: XianLiang Huang <huangxianliang@lanxincomputing.com>
X-Lms-Return-Path: <lba+268a7d7a5+1539f1+vger.kernel.org+huangxianliang@lanxincomputing.com>
Message-Id: <20250822023611.18145-1-huangxianliang@lanxincomputing.com>
X-Mailer: git-send-email 2.34.1
Date: Fri, 22 Aug 2025 10:36:11 +0800
References: <aed0e72a-3c98-4027-8676-b8f469d857f5@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> I suggest to take another look for the better distinction of mentioned ke=
y words.
I misunderstood this
    >> =E2=80=A6> Check the pointer before using it to avoid the bug. =E2=
=80=A6
    > Would a summary phrase like =E2=80=9CPrevent null pointer dereference=
 in riscv_iommu_iova_to_phys()=E2=80=9D
    > be also helpful?
https://lore.kernel.org/lkml/effb29be-6d14-47e5-ab71-454119467750@web.de/

>> > Changes
>> > v4:
>> > - Change the summary as Markus recommends
>> >=20
>> > v3:
>> > - Remove redundant pte validation in riscv_iommu_iova_to_phys
>> > - Improve subject line to emphasize prevention
> Does anything hinder you to integrate repeated patch review ideas better
> into your contributions?
Do you suggest merge the repeated patch changlogs?
may a RESEND v3:
- Remove redundant pte validation in riscv_iommu_iova_to_phys
- Improve summary and description to emphasize prevention as Markus recomme=
nds

Regards,
Xianliang

