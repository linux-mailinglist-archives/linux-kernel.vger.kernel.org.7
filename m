Return-Path: <linux-kernel+bounces-883259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C68EC2CD0C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D532934BC33
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B99530CDA8;
	Mon,  3 Nov 2025 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1SZWNMI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98970283FCF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184102; cv=none; b=cXKFipJuAHEf44jQAQgw/hbFCiKXB0GYc43vk6X+NHTTetGmh/7Wyc8ws0Nm87wgzGU8dxt8q124I1KZOjx2ryWCmoKKh6q5sY+RpxqgwA2jZlPVrLbwCTKIxWS3KS7Pt17cV6anrpkZikZQTU6afE5js73QVWd5XI4x3NaN/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184102; c=relaxed/simple;
	bh=SW3TIGJMIg2vrHloehmaqeDzoU5scfUDSDR1CcoNKng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlTesun0o1l9ElURMkDtjQ4voQhzbDEIL1Sb9EUrmsY7sbGtdn5Ds4+Lu/o7shdAahlxiYDMVsDzWZKxoCrZLuZ32eNlUSMgc/D1NJdsjJ7kEz6sHBuZGZ2E1uqucwfME6tp71/9oYiLTx+ew7/9e5m7EVRHjDVjyvEqr3MFBk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1SZWNMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CBFC4CEE7;
	Mon,  3 Nov 2025 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762184100;
	bh=SW3TIGJMIg2vrHloehmaqeDzoU5scfUDSDR1CcoNKng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1SZWNMIZMQHmORDR1eXot94vuaJyuwhm1tY7qBUKwmiMmsXoOEd/WypbgK4UCjzW
	 0wlg2yxf0diQGD2A4gFPynBnUThe/u0TKyKrN13f5yIyYEC0Yz/GNu5WPwcCItdnJC
	 5eFrA1Gy/88eeKfOeyzswLjxrO4c7nlcExPp24S/VBOwTCu5+EWi5j6j4JCTC2bWOk
	 vvz9OsLfLCFYl5vqIWjtVPqP7jt9KiisuGUAVyl/+3ahFF13udAj2ltVW/8uZKO/cy
	 zfsop7INXlem2UbskYIMasQP+J249Y1fQfNuva/YxYMPF6wiTayv83iFsrlE34wjCS
	 2n/sczJuxZLjQ==
Date: Mon, 3 Nov 2025 08:34:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix typo error in nvme target
Message-ID: <aQjLogHkN2hPwsBs@kbusch-mbp>
References: <20251103024131.1855-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103024131.1855-1-chuguangqing@inspur.com>

On Mon, Nov 03, 2025 at 10:41:31AM +0800, Chu Guangqing wrote:
> Fix two spelling mistakes.

Thanks, applied to nvme-6.19.

