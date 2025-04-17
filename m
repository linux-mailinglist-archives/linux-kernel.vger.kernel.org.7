Return-Path: <linux-kernel+bounces-609359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94341A9213E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 17:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284813B93B5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7069253B5F;
	Thu, 17 Apr 2025 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNXQ/kT0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10485253B50;
	Thu, 17 Apr 2025 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903132; cv=none; b=s7mp2hJj76/28Odc4LwI5rUzQenizr63aEU1cSqHCDvfL3dXYhUFvmUVBP011ps8D3guW15pAO0hKlDsyJX+iJxosdn1A9GymimcC2mWXBgdP5/uF7LGx6vBmt8scGsVW7xbSnkzTcn6jsOsK4ejQBBw2RCwnsCfustifGvz+7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903132; c=relaxed/simple;
	bh=fAdwmBvDWfknm6kM3iUJ9T90mtg2EB2ea1pIuluMZxk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X0VnVYC9oHNY9o2VAftNP2NJyER1gztP08qKjXynY2cycgDUDpGgzGprtK5BOukGDS4R3f92W/ZcxJ51n9avhnUOl7Os20tBdiIu5lN2JU3FnWHNWftpFPp34CwZ12dxMJCcHGZJWw6HPfb4t0ORsEtbqLIT3bsFtoKW6mfFc+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNXQ/kT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBB2C4CEED;
	Thu, 17 Apr 2025 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744903131;
	bh=fAdwmBvDWfknm6kM3iUJ9T90mtg2EB2ea1pIuluMZxk=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=eNXQ/kT0mF1kt1OBrNeeEoG212p1AiGiokCIFkvYZ0mq78A26ciSFd4pqF6M/R4d5
	 K4Va7Ysid/cpkevzuhyK+QakQQjcdjT5A/5fabXAYiq5qVyDPpyEWTFHslMM2aDBQA
	 HnsdYhYjJU10LWp7Ani9wLSZCy59MS19TpFa4yikHlHIDnH8mC2TETKYEBl0rOzG4V
	 0xhhob2jbN5FiI+rVJSh/ImAUKg3TzChlygFzYHr5QAWLFpEQfuAVuPzi0BYYN0edw
	 +lNaY/zbxVHYI6T/58v4lSrY+EVmNc6ansvVAeoM07OsZ9at02CZor8gQuiAvmQvfZ
	 bNsq8vRFtz5lg==
From: Vinod Koul <vkoul@kernel.org>
To: Basavaraj.Natikar@amd.com, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Eder Zulian <ezulian@redhat.com>
In-Reply-To: <20250411165451.240830-1-ezulian@redhat.com>
References: <20250411165451.240830-1-ezulian@redhat.com>
Subject: Re: [PATCH] dmaengine: ptdma: Remove dead code from
 pt_dmaengine_register()
Message-Id: <174490313001.238725.12942298542601347160.b4-ty@kernel.org>
Date: Thu, 17 Apr 2025 20:48:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 11 Apr 2025 18:54:51 +0200, Eder Zulian wrote:
> devm_kasprintf() is used to allocate and format a string and the
> returned pointer is assigned to 'cmd_cache_name'. However, the variable
> 'cmd_cache_name' is not effectively used.
> 
> Remove the dead code.
> 
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ptdma: Remove dead code from pt_dmaengine_register()
      commit: 862f3c49a86b85f314c09437d0afd1afc2c02fdd

Best regards,
-- 
~Vinod



