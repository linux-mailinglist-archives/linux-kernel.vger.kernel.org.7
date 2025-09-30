Return-Path: <linux-kernel+bounces-838245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53884BAEC6B
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 01:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126ED323540
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA8425A343;
	Tue, 30 Sep 2025 23:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6YP6CIC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E2FC0A;
	Tue, 30 Sep 2025 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759275125; cv=none; b=rNDmw5D08c9Wt7PGFLz5z0eRvXTc7IYJAHyL1dVGFb14De9Ihxcrl2q/WvhblDUoOGjOhThuUdwpHMWzsotL6TM8UlSUaUTp82BcjQnQJ5W3QU9W8eHRXBGyST+uWuF0avhoLmqXW4ZUyCG5yfLIRRlYqWqZ+0DFfFCOWYZRV0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759275125; c=relaxed/simple;
	bh=GDbSboSb5BvYHNq3EQTK6C09/FEIZ039swl5YbqFZd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5aXsDRrvWjadMKMBIeNn8tEWwJ1D268ZmtPbFp9qt0f02jcNm8Zk0KzZ6NEPz5OCYrt8Jy5PfbE53rErHvx+yayZPZyJhehFDohP0uSnGmcH4RjC/jKrDzIMkpMFVvSQk0Fv1yWoVGCm0oQSXmWHFaA6ZjB7AKqeVffRYOfkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6YP6CIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9127C4CEF0;
	Tue, 30 Sep 2025 23:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759275125;
	bh=GDbSboSb5BvYHNq3EQTK6C09/FEIZ039swl5YbqFZd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6YP6CIC3BIuTaJaNJHgtzppZVJ5n79Q4ts0on/8ppadRpMJIDKuyNPVu0qpi9yp+
	 BNzLvA/Pl1sjarrVFIECIdAmyJLzP4EXWFQJvwHbIeLzhE5DQuZ5du+Q3ujI73/kVw
	 /4xabwMC4WsyYHupkVdzlw/ZVNfnAdMDaFLQ8lcp6pLtujL2Mg8VaNHjwGsMFybcz3
	 g84lF5jWanJBlfGmN+H346LQKG+Il+g/k28ZQbBinHH5gZ7TSZb21FbXyYfwmpp6al
	 7nAtWh7A7wFIs2u8IP/gVgDmCC5LgvLu1P7XIV91en66Sn3WCZAAjcA6AbHNf7FDRn
	 RUZZ82oJ1ObKQ==
Date: Tue, 30 Sep 2025 23:32:03 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drivers: hv: vmbus: Fix sysfs output format for ring
 buffer index
Message-ID: <aNxocwzwJK6MCLII@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250913192450.4134957-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250913192450.4134957-1-alok.a.tiwari@oracle.com>

On Sat, Sep 13, 2025 at 12:24:42PM -0700, Alok Tiwari wrote:
> The sysfs attributes out_read_index and out_write_index in
> vmbus_drv.c currently use %d to print outbound.current_read_index
> and outbound.current_write_index.
> 
> These fields are u32 values, so printing them with %d (signed) is
> not logically correct. Update the format specifier to %u to
> correctly match their type.
> 
> No functional change, only fixes the sysfs output format.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Applied this and patch 3. The second patch is dropped in favor of the v2
you sent out later.

Wei

