Return-Path: <linux-kernel+bounces-828904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D872B95CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA52189BD3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1629322DB5;
	Tue, 23 Sep 2025 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SD6zoZK7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDAE27381F;
	Tue, 23 Sep 2025 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629583; cv=none; b=D96xjKZ7WHoXepilmsj5kt4YSHKXatiTmefqFiu9WKcBetSeHnlhQOWcQ4vtqlzflFYqaBQYd4EOvkvXrpg+hZ3rmQDkq4EVv6I3YcT6NShIE8l4o9WbnbSKPT/vAYGqesCWEA30eAUsY0KzbKTrbOOSsY++5jEjIc7j+mKKFkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629583; c=relaxed/simple;
	bh=nLWYf0OwuL2QDSZ9erR+SsgjbMnVQF8jkOaB+MSzZwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7Wgrj0NtX7NEHMtKsOmubkde0sdib7NtxiXJCmQ8nlpkwFcW7iU6y11R0Yvp45KIVKfi+whWCPa2lYmkDOEA/zbEMfuYXqgS3j9JmX0d2Nq1aAYZZfv/dcLMmNPLVxoGDCxSuE9SjnKwBoTaln5IZqILoHtNqnESiA2EKhMVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SD6zoZK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DAAC4CEF5;
	Tue, 23 Sep 2025 12:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758629582;
	bh=nLWYf0OwuL2QDSZ9erR+SsgjbMnVQF8jkOaB+MSzZwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SD6zoZK7Hm+HYZP4k12JJZLMxs6743TiF3b0nPTUswtkpN/fP8wdU1tXyinT11CMR
	 IgImXDf+wYAOB6szSl2tSDBHxHGNYzEql00xuWqrPHvYgzc5gN3VDLCAJumdGrMq5Y
	 ILwOKjItOK54cp8my48Yq/4JQW8Y1olm8M5QL5oA=
Date: Tue, 23 Sep 2025 14:12:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 6.18
Message-ID: <2025092338-wheat-legged-0d49@gregkh>
References: <20250921075603.14452-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921075603.14452-1-djakov@kernel.org>

On Sun, Sep 21, 2025 at 10:56:03AM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the v6.18-rc1 merge
> window. As always, the summary is in the signed tag.
> 
> All patches have been in linux-next for a full week. There are currently
> no reported issues. Please pull into char-misc-next when possible.

Pulled and pushed out, thanks,

greg k-h

