Return-Path: <linux-kernel+bounces-700044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C84AE6315
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 12:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA093B9160
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 10:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1DA28A724;
	Tue, 24 Jun 2025 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apQJ9zhq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2110028937C;
	Tue, 24 Jun 2025 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762552; cv=none; b=UIxdpleobXQtWKrmUqtAYoLAgimyv0V3evScaJ/RMvCoSTsYhHHwOisf3HsEZMXakCnky/gyg3MCxx2wIQ+MeYev2ipKdNpIH3AOC6xFEQdmpjkag3jpHxM+HLtzpy9+f2j+oc4iRbtQvF4AJluSFS5dnF5Nthld19eGEsNy4lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762552; c=relaxed/simple;
	bh=a9/Pu35xIOPRs7awMdPyOLUKxuJwWfzZi7O2cJbjlfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2xgYHe8JNg5pr0F3BM2/SIF6laN/iMZVmP1ZUL8imo802VbLzsXg6JzDrE7BvqwgU0RD0nTjfW2x/BaDHG/o3CYhZHiYj1dtW4PhEAR6VNvDy6NVf7PL04gxPneZwsRIwL5uopY4na2qQSSCEd+948eouDHYyArthz2TY2AKI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apQJ9zhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585D5C4CEE3;
	Tue, 24 Jun 2025 10:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750762552;
	bh=a9/Pu35xIOPRs7awMdPyOLUKxuJwWfzZi7O2cJbjlfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=apQJ9zhqclJT1PiC3XQCL+gRo/wvGAHoXdq1gAn9a5eiqYxanp7kJy3B/muPw1yay
	 ufMhdZxBoUYWHGfHvqLB92YOqXBGT9URqwTKem/iFcoWRuZt9Q390urayCKa/zqy4K
	 vHjhafefOy24Hsqpz/7L3TiXXV0cd25RpOhdVaq8nvj6K3zJZY50/vfwVo4S8KXkhS
	 KXPCVySrcG1FnlGho3JJtebCqC0Hp0CKDMHJDNERlZ/c7J97Ht8c5NnxIfXC58FGVU
	 uLLvFQV4hDyObUI2PBe+YnmX5arR9daNA0qX+X4B+vKpJik/cKgqZNUwTGogEJY+JI
	 lyuh9Qw5o0rXw==
Date: Tue, 24 Jun 2025 11:55:48 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, gnaaman@drivenets.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] neighbour: Remove redundant assignment to err
Message-ID: <20250624105548.GG8266@horms.kernel.org>
References: <20250624014216.3686659-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624014216.3686659-1-yuehaibing@huawei.com>

On Tue, Jun 24, 2025 at 09:42:16AM +0800, Yue Haibing wrote:
> 'err' has been checked against 0 in the if statement.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


