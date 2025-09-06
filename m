Return-Path: <linux-kernel+bounces-804278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01879B46FDA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A444C1717C8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9CB2F6193;
	Sat,  6 Sep 2025 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="on7TblNf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C6A2DFA22;
	Sat,  6 Sep 2025 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757167125; cv=none; b=FCFdLxZtWjKh/32sS/eb1cPrZ9lS2EzGDON/r2RgbDVrpwbDQhA8IX+49WaoaLRF6fnGnaSn4wGAsHdDfyvqthVlL6DcrGFTf2engu1k2cnxRycvuQA5xnKKZcZFiYC5NYBnzh7sbSjEQDcozFnaDCGJLMBCtrrpsX+I5/KD00U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757167125; c=relaxed/simple;
	bh=Jk8jJMAAw5h0SFOfhY8r7a0HQCnPXtn5aQstdeS29O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCesf0J5Qp9sS+nyl2reW7NZiJGTbujs6ia5RgyQnYpuzTFPeoomSMCxmGf74YJtVz3PT8TBeEp5mG6G7zFdPsoG/mZ31ZHUXflByCIEMLKXWhKB1PS0cbarYTJTU95GAqEzvSh7N5UE8yj9W3LpxcmpzbpJlSyDyaHaVcbFNgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=on7TblNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81370C4CEE7;
	Sat,  6 Sep 2025 13:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757167124;
	bh=Jk8jJMAAw5h0SFOfhY8r7a0HQCnPXtn5aQstdeS29O8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=on7TblNfR3rqgS+WV7j4cnQfjigjdoetXyIJV0Ww9E83COm3hWfyUFgjdcMnEfjJ7
	 qIfg/8gNtAKnGecv43+obhMwsW5xbjQeJNxC/RnBBXLLPilz33qvNzpK9w3RgdBQk8
	 j3cuPmIm36rmJI1oR4JkbvMAl3y7MguKH3gejFCo=
Date: Sat, 6 Sep 2025 15:58:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	patrick.wicki@siemens.com, stable@vger.kernel.org
Subject: Re: [PATCH] eeprom: at25: fram: Fix chip range in comment
Message-ID: <2025090633-retreat-perm-c97e@gregkh>
References: <20250828151648.348612-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828151648.348612-1-alexander.sverdlin@siemens.com>

On Thu, Aug 28, 2025 at 05:16:42PM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> The first chip supported by the commented code is CY15B102QN, fix the
> copy-paste error.
> 
> Cc: stable@vger.kernel.org

This is not a stable patch :(

