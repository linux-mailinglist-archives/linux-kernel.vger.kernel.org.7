Return-Path: <linux-kernel+bounces-885397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 196C6C32C92
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9905818C080E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF58154BE2;
	Tue,  4 Nov 2025 19:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxLKM4G0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984208F54
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284644; cv=none; b=Z5un5KOKWA6TCrkMkYKiVgYefmSou9saSFgHwcb6ykFaeBbGghy5GL38+L9fNy/tVkcDHpWVSUxAjkO7N8xzca9423YR+4dWVoMg2b+LuvLcTJqKZm9zsNl7u6YGsJaMJP4gC/VA9JWtin3lwZv9VWRAyvmYYce0gEOYThakTNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284644; c=relaxed/simple;
	bh=4IGghb+PdozHytQUZpeqOp4t9p9Ko5vzzEC9iU5cpEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlQut8VgrlJvJap0IUuUyGa9TIPFhAwk1iVz1BSAYJmmfENXZED7fpJTZTd1WHGiY0PEL0sji/oDmQkUVK7GraTP87T060kNHbDlsVOSUFuAfdv5gnMpamVAOKStIl/h0THGhNrRYq4XUbYNtd4EpIrDoJfQ4evl8yy03GWBUUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxLKM4G0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166CCC4CEF7;
	Tue,  4 Nov 2025 19:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762284644;
	bh=4IGghb+PdozHytQUZpeqOp4t9p9Ko5vzzEC9iU5cpEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxLKM4G0udzgWHz7ZlarbroDDhyS/VyIV1AJnUUxpFzC3r/9EH/Ebtuub3vNX1uxc
	 4GQ6lDqzx09VjwgmoOvJSkjoZG2w/uWrxg/uutW76Rklanp8ZwxFBCQs+SRHQe01or
	 76+1J0rE82E1SWzi+oJe6iBBFFrOw95E+tv9jkjy2Skv2nWN+6uTDcEnPdfdjFKlKz
	 +eqe9gRBTohDTliOpQz6ZFy6jr/1euWOnKhyhD58MrfKAIA7tQsnFwHaj5xX62vHKW
	 8Ip2MFQmnWPiToH/QCQiXyQrDj9XTk2Hti9sxdCp+5xmf1N1B4erT0z4HoTOk7hHKn
	 iOqzzjRBHeV5Q==
Date: Tue, 4 Nov 2025 09:30:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: DEBUG_ATOMIC_SLEEP spew in cgroup_task_dead() on next-20251104
Message-ID: <aQpUY7fEp6_ZqGel@slm.duckdns.org>
References: <20251104181114.489391-1-calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104181114.489391-1-calvin@wbinvd.org>

Hello, Calvin! How are you?

On Tue, Nov 04, 2025 at 10:11:14AM -0800, Calvin Owens wrote:
> I'm guessing this is related to d245698d727a ("cgroup: Defer task cgroup
> unlink until after the task is done switching out")? Is there any other
> useful info I can provide?

Ah, I need to make css_set_lock a raw one. I'll reply with patches.

Thanks.

-- 
tejun

