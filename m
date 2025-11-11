Return-Path: <linux-kernel+bounces-895100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1609CC4CF25
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 640A64FB180
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00F7339B36;
	Tue, 11 Nov 2025 10:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fu6D3vTL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7EC333735
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855361; cv=none; b=raqUAavojx2baiMaYl4krxXzh2HG9VJl0LNfDXcyEOuJ5iA3xyhbgJJ6Quo8icsoWixHYpWpuefk0kpeAnmJSksM8wDYmB+RPvtSOXjTGybJEwh7xreN9dSzZatw6QyBDK3fPo9rOcgTzAUkPwYB56Pt7dU7vNURQaQIYXvQgM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855361; c=relaxed/simple;
	bh=qbK+9omSbAIIGfgDmKv848eQGINyIhkpZhN4H5C6szA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eU/MBBKj2ZF+qoJ+kBuIqw1pMKD9u/vNtwLJ917flTgj/DX2aSdleewd7m5N9EMJ+6T1ErjJ7ViLwGB5vhnlGiTBh19RqMCWKu1ZQVCPPf7WwNTpkpxVB6tzvd0N2gC6saMlAKMmMVPGL9w18SsMCaCYxeB8vXdHpnWSkQMjg+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fu6D3vTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23941C4CEF7;
	Tue, 11 Nov 2025 10:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762855360;
	bh=qbK+9omSbAIIGfgDmKv848eQGINyIhkpZhN4H5C6szA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=fu6D3vTLsbEit5jA5PAG4eb4JM9xiQIWbDFMuwFBEt9NMMg+2UGjbaojXJBJoDK6p
	 2w6aFcpULuadwc3T62I1VtF0hZujEdjWkVHZOwPzvYIavyy+UEBnIv2aCxqMTa8e1f
	 yQCd2v65iKABU3Oubt/pS9qdJ2H7CDxel8YvjkQiYjLmW8NPsEmjAsTfH/mp/Fgukt
	 uusTMmGrL9LvKguzcST1b23oTN9CdyW+hyr5+8m3HpQF/kuAm4pb8wFAaGx0bWUCZ3
	 ZvqxOJILhhdg+AF8roao3DIyZx+SCCU+TQDKdpwHSX/sSEF61PmnMf2AOAoVJJOKx7
	 QGCEb99GT5KMg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
In-Reply-To: <20251111094302.95003-1-sakari.ailus@linux.intel.com>
References: <20251111094302.95003-1-sakari.ailus@linux.intel.com>
Subject: Re: [RESEND PATCH 1/1] w1: omap-hdq: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-Id: <176285535989.36949.3879050525438712590.b4-ty@kernel.org>
Date: Tue, 11 Nov 2025 11:02:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 11 Nov 2025 11:43:02 +0200, Sakari Ailus wrote:
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> 

Applied, thanks!

[1/1] w1: omap-hdq: Remove redundant pm_runtime_mark_last_busy() calls
      https://git.kernel.org/krzk/linux-w1/c/a5d908e0ec05bd4f5dd818160f0252861879a5a2

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>


