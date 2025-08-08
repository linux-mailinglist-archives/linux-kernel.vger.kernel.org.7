Return-Path: <linux-kernel+bounces-759820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B781B1E336
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D0B27AB5CC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04316256C9F;
	Fri,  8 Aug 2025 07:19:36 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C123F412
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637575; cv=none; b=NtF/n564fnaSh7BebpNR56S6du0jYoRU+vB56Jy1MMvntKTvRVloocXd0zIKhEUpAB1QNK2UPBaKFa5XYu6qRS+PcynoHBiPOOl0oRASteVFB3SuW4bo74vWFuuu7Rawzv7aOKZlgXt//ABSXYjMkp3K2rTbbnhHdX8bRTugDks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637575; c=relaxed/simple;
	bh=iaacfTmHkEjxfpL7+C67swcZ0r0QhcmlL71iVu2bO3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UuUaoN/nB1rlIF3ZdCR88fGPk/botI5hHWGbfqCxR5pg3nNU03o3JW8h4qtxJveUqYC9AyS86FxC3RyceRXx+a2SUz4cKVVD2HUzzSonNf9t0Cq7gqyEsEFkp/1Z75/m/YJI3lsv/yIhv6ZOiWo0tSkWIsCL4qP2gpj7yY3H7bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201608.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202508081519226129;
        Fri, 08 Aug 2025 15:19:22 +0800
Received: from localhost.localdomain.com (10.94.14.254) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server id
 15.1.2507.57; Fri, 8 Aug 2025 15:19:21 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH v1] [PATCH 0/1] add Yhgch soc chipset support - Supplementary Cc simona
Date: Fri, 8 Aug 2025 15:15:38 +0800
Message-ID: <20250808071918.52377-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250808053508.52202-1-chuguangqing@inspur.com>
References: <20250808053508.52202-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025808151922a6c6e9e9a299aaade0f208525afed415
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

I'm sorry that I misspelled your email address when sending the patch regarding "[Original Patch Subject]" earlier.

I'm now forwarding the patch to you as a supplement, so that you can review it and provide your comments.

The content of the original patch is as follows (or directly attach the full text/link of the original patch): 

https://lore.kernel.org/all/20250808053508.52202-1-chuguangqing@inspur.com/T/#t


Looking forward to your reply,

Thank you!

chuguangqing

