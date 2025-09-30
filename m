Return-Path: <linux-kernel+bounces-837262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F438BABD02
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263813B00AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B282BD016;
	Tue, 30 Sep 2025 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="KDwEpD6v"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDEB27B328
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217136; cv=none; b=WkHg/d2icA8NB9RkpwT/yxAYjYW6GZQpGr301IB/lhi1v5RmZFubxuhPTEdphMhXEW1ATANenZ32D1dfdqF1wg+ASkAMLLsul3j7t0Mpf4Lrnn7skoMtau18PeXhGIsuAuo9uzi1NSZSXZX7PTmOGuwWQ04Q+ZBXILzy5glYPQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217136; c=relaxed/simple;
	bh=YNuBnostWL8+rTUzPx9qE7Qu63k49QOm2YvDuxwOlVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvsVsp/tbsWcNVsENE024uF5fUToByOj62NoHuhb2EmVCf5rMZ4a/sIc5GCqn8Aylg/C8911sgIPycuwLRQ9449KHx/BL1U9bAKHD7sQGxUtUypQnW+bmUWZrRlbrbytgQdMLanCu7n45WFjQqhmgpYA4MhAGz69T8Y0gwwuxGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=KDwEpD6v; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ORh3BEPV+WOquku+9ljKakwClSRpsC/pErO19VSvDzg=; b=KDwEpD6vP8UTF1F7qBSXLjRQ/P
	bbw3sc4d5wKGaldhM9SRUcpH00S5UdZ9TF72MKgRb44mwBwwm2vlNQhGS+a3LIVmfLvMGtS6FOtmK
	eytlNNFf5/dx88jla4D+xHczGEr7RgrwtoDSkLNPnL1+9JTXjeygQIHKY3Ala+kfWfwL8AjzCDhQ5
	ZxnE/5DqBMx5c+ghJxDXX8SEQc/m6ed8hGbMz4FzB+UiBi3BD4fz7Guy1wYy2Z6Tci+TmPqRn7B/N
	2pMbGUy91NpRbjhXCpu3Ta1G+Yb9qppcwHTPMvAXc5pzgSqPkFi4uOZxWpPj+g6etd/nuhNBnSmdh
	ATnyj1mQ==;
Received: from [63.135.74.212] (helo=[192.168.1.249])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1v3Ujd-004k1j-AX; Tue, 30 Sep 2025 08:25:17 +0100
Message-ID: <066d70c7-b0a7-45e5-9337-17901bc95664@codethink.co.uk>
Date: Tue, 30 Sep 2025 08:25:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc1
To: Paul Walmsley <pjw@kernel.org>, torvalds@linux-foundation.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk

On 29/09/2025 09:00, Paul Walmsley wrote:
> Linus,
> 
> The following changes since commit a03ee11b8f850bd008226c6d392da24163dfb56e:
> 
>    riscv: Fix sparse warning about different address spaces (2025-09-05 15:33:52 -0600)


Is there any chance some of the big-endian work we did is getting in
for this round?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

