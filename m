Return-Path: <linux-kernel+bounces-858315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CD6BEA1C7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EADB6E57B4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3186F3570CD;
	Fri, 17 Oct 2025 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgvtXqc0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE32F12B0;
	Fri, 17 Oct 2025 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715173; cv=none; b=ZUhTWmyGrVEjkZhVD9w9BO/jZt3LQO1LOpnWsf3etNp6lMddDcDoBdVgDU7DdrqHMp8k4uW7CKQYaiZiw7tk0HmNHE/EbltIRHCcB/eTYRng4j+PJGBhPTM/3m3OuV7PvUSmt/XHK6COOeUBp2BSGn8nbroL6aiJb3PQws9KF0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715173; c=relaxed/simple;
	bh=YY/SZDNQYaPlzHGsqMUqWnbUWbYHTr8zsV6AhsNp0JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJ/5OTTFdjNvqT8C1j3Tn/TPtDxWOc0wLgqvI4ihHOASOmubgEqkC9nh9/f40R3frCrrG9EdSSgbNQ9bRqmTBloanY58mbgRVrUZj+HEP+5rL5uS5ycNARX0xrFZ2+bRUkXrbvD/sYd30ygp82CmrtXmi6OMsSEycijPnkrD3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgvtXqc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B134C4CEE7;
	Fri, 17 Oct 2025 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760715173;
	bh=YY/SZDNQYaPlzHGsqMUqWnbUWbYHTr8zsV6AhsNp0JE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DgvtXqc0Gv3IZigp8TpZw3ZYpDvZ3dwFknjK8LPBA8ekoc5+dqO8CWfSlYX1jNnBW
	 lpoLhQUiq1kqVLVFESTQsJR4eBtxB5rQAKMXCZ5w84eSikIWf8yPIHlH44RURoLDLT
	 TpThmnsc7kMrPF5fmQdAELqZ8bLTKW/BsbLNOwAHfRfUaaTmfniX+oUz5gbaMo+j6q
	 TMOjKqRu2dPgsljvJnLKH8CkpKTueytEd7QAOuHb9MqlW/NOYkTxXUjG7MwyhCtZ78
	 HN1L7UCuKGQnjgc4hiR9bCBrSM4VLhDd/7E0ZFsTDu9g8PSWoXtQTeJjnakeIOhI5W
	 aMFm6izYYNsCA==
Date: Fri, 17 Oct 2025 05:32:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Zhiming Hu <zhiming.hu@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup/misc: fix misc_res_type kernel-doc warning
Message-ID: <aPJhpJDcYUkQ1eTl@slm.duckdns.org>
References: <20251017070743.1638456-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017070743.1638456-1-rdunlap@infradead.org>

On Fri, Oct 17, 2025 at 12:07:42AM -0700, Randy Dunlap wrote:
> Format the kernel-doc for SCALE_HW_CALIB_INVALID correctly to
> avoid a kernel-doc warning:
> 
> Warning: include/linux/misc_cgroup.h:26 Enum value
>  'MISC_CG_RES_TDX' not described in enum 'misc_res_type'
> 
> Fixes: 7c035bea9407 ("KVM: TDX: Register TDX host key IDs to cgroup misc controller")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied to cgroup/for-6.18-fixes.

Thanks.

-- 
tejun

