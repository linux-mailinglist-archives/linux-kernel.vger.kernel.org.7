Return-Path: <linux-kernel+bounces-829544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AC5B974EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CD2167E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42981303A07;
	Tue, 23 Sep 2025 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkSS2RqY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E6C27EFEF;
	Tue, 23 Sep 2025 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654811; cv=none; b=QMzwUvVmUvKH2sX3pESy36IITBZWQk+AzCbITegmrzcebiXmXQCOf0YNuNWh1bh3I6jxVuRb0i7D/7HeFJiuN2ynqdQNsOo48t+sbOKFyminaVLu/6rL+nhARFiGHRI24VIMLwAhJ+OHehP+WCXXVUzHmwzW5DIjBOYsly88pzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654811; c=relaxed/simple;
	bh=KmHuNopOLb79Bn2haFhbtd6jYum4xB9MMrclSXHp0lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RveXanEFtMkF4ELcxxmVjbG97j3eXQvTgKzVqBBaxi+o9WnEb0tg3JSiuWCMvBr/dNMh7fBDLJ0E51w8y+ufWsNZY3OiLg0oyqytw8NcG9ZDkXKvJ0BLY5L/ORyyBcwWw4Ko6GzezWPpHHl2ApIztxTIz7XqxIzW7PUw2zg3rR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkSS2RqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF103C4CEF5;
	Tue, 23 Sep 2025 19:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758654811;
	bh=KmHuNopOLb79Bn2haFhbtd6jYum4xB9MMrclSXHp0lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PkSS2RqYqe/DoOc+f2je1sfAvXbLPYm37c7iLGKLsLcpBcIovkxGU96NQVbpFBLm7
	 hiBV/dp2p5iFuYrv19KVCO4gdu2T63AyrVUvGDmWxdp544kZidQCON6/fdFME+2SSB
	 FoQs+GlOFnoAkNC7qWgBtusN43/LBK4K5zJCzu6GM4+6Xn4a8Tdf3NOrL0ih/SAodE
	 /fQ5cKHGjBd3+tC/HzAh4Wg6fYxllZzOV0S86zP+Im9hla5CUVOfzqwbfulzymcCKc
	 YG1R8E9V7uMx9DYdBikSgRziKAtbnO2r9ITZWVDQJYJxNxD3tA76bWJ2goW1fZaC4+
	 d5tLWhA7tEU6g==
Date: Tue, 23 Sep 2025 09:13:30 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/7] sched_ext: Use rhashtable_lookup() instead of
 rhashtable_lookup_fast()
Message-ID: <aNLxWlGGlnKbysg0@slm.duckdns.org>
References: <20250922013246.275031-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922013246.275031-1-tj@kernel.org>

Applied 1-7 to sched_ext/for-6.18.

Thanks.

-- 
tejun

