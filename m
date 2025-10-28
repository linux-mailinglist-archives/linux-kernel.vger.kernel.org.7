Return-Path: <linux-kernel+bounces-874587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F165FC16A13
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9855B3ACF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE8F34F47B;
	Tue, 28 Oct 2025 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnpuPXY6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6966E299A8E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680206; cv=none; b=OAsO4EdnAJ87CSe3spsS7mWi7DceV2xYOdYbB/JsSAeBwtSruzJSw9MqwQq4Iwtv2RQL9wJdES9QkxWXyq8hNmxfM6c5LExR6n6wtx7e3vjwPpg2Z+GjBG/lEyCQ/qRi1D9D3jx4HJmpS7eGz/MRWPM1phtFw1CPX7YbAiGvysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680206; c=relaxed/simple;
	bh=cND5uynJcU2RD8dlhPIJwMn7Y5MJlrgwY2gSU6Zy9uQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BQNNYNPeLUaxgOVgLhLAm+59Js0yz8XMbU4NyypbjWMzI8WHBrd//jcOeH546rnfZw0eCHfOtXyX6pMocVFjMz6ssrFYou6iN3JkRh4pyD2FkdluPpaAaXNljbMrzxn7ptLxps87DOyJp9dEA6B1FPARl/nJcoIHnMuQz8SvAXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnpuPXY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D2AC4CEE7;
	Tue, 28 Oct 2025 19:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761680205;
	bh=cND5uynJcU2RD8dlhPIJwMn7Y5MJlrgwY2gSU6Zy9uQ=;
	h=Date:To:Cc:From:Subject:From;
	b=fnpuPXY6Q267/Mpw3pbc9Q/y+gSF52+aa3LXOZIiA6fxvDnSwOuOMU0NtFQSd+6Xk
	 S59bizULK/xVFiVvWYOKMetNR8ucFGm5S/nGpOOMVJVXhmfCfT2260WL/dp7R1dCMV
	 d7tNFk00G2S3b6/PcMMqu/UPJUX0/b/zg4I9KdcY6EACaasvDVrzWX5l5H9xtmJfW6
	 ZPkobGnAamxEEbpFbvuzUgU1Zbot8mnYxCryLXZhJNAgnKTbwNQwnwnJPvwl0TazNP
	 kAJpnBLlSSujmvDQHL2qZEIzq+6PrIkCZ28wYC5FSmd4Wz4cLi5QkSQ17aVgVL3Hlc
	 SaLvL6Pb9V/RQ==
Message-ID: <dfa4d9f3-8b56-46fc-9d1b-68e07a3d6edc@kernel.org>
Date: Tue, 28 Oct 2025 13:36:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "conduct@kernel.org" <conduct@kernel.org>,
 tech-board <tech-board@lists.linux-foundation.org>, shuah <shuah@kernel.org>
From: Shuah <shuah@kernel.org>
Subject: Code of Conduct Committee report for April 2025 - September 2025
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Linux Kernel Code of Conduct Committee: September 30, 2025

In the period of April 1, 2025 through September 30, 2025, the Code of
Conduct Committee received the following reports:

Reports received: 3

Code of Conduct scope and enforcement related reports: 2
  - Education and coaching on the role and scope of the Code of Conduct.

    -- Report about insensitive comments about projects and code that
       don't fall under the scope of the Code of Conduct.

    -- Report with questions about DCO which doesn't fall under the scope
       of the Code of Conduct.

Actions:
  - Ban on a developer was lifted after it expired.

Unacceptable behavior or comments in email: 1

   - Resolved with the individual making amends for their behavior.

We would like to thank the Linux kernel community members who have
supported the adoption of the Code of Conduct and who continue to
uphold the professional standards of our community. If you have
questions about this report, please write to <conduct@kernel.org>.

Please visit the following Code of Conduct link below for information
about the Code of Conduct Committee and previous reports:

- https://www.kernel.org/code-of-conduct.html


thanks,
-- Shuah
((On behalf of the Code of Conduct Committee)

