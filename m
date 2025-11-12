Return-Path: <linux-kernel+bounces-896464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CB6C506E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1FB3A566A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD1A2BDC15;
	Wed, 12 Nov 2025 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rL/+S2gP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475E94C97
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762919065; cv=none; b=YL67kCZeNBXdxsGWYudKU/kf9FMszNnvg2yzMq6DD6gfhj16MmwALC8nCyxzXsmIaw4MA2N3BJbrGtmrVqIbUNjiikLaEaRL8mM4e51BMDu4TGLzwS00A56jL7Qq8OvFuWb6Fvf2fAxPQqzzsmhCRdcb7INx61vzOcdwQ33i+r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762919065; c=relaxed/simple;
	bh=dLQarwf3As5LI0u0lW2iT7LXfqUXMiKIndZqaqEbDkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bwqZDmeV1RjnyV/IjwjAEhMZYdfgfCmzfYhmnU+f2WOjephL0Qv+npgGsJRGJlDgntKxE9MeHikP71fISRL+T/5fZ0oCSEz4CdiyJC5UKrYVhnqQK6zGlFWaTlp/ZV8eqA31ZTnHhT+PY/gZe4ZyH5WKL0qlY9eYn8G34fLaa24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rL/+S2gP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6E5C4CEF8;
	Wed, 12 Nov 2025 03:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762919064;
	bh=dLQarwf3As5LI0u0lW2iT7LXfqUXMiKIndZqaqEbDkM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rL/+S2gP2lEjbZ6ZPEiOLz2Cl1KsmsLnBpnAHAWEp/OFLwdEd2pZoT1EmpF5ys0aC
	 +RlyGBnqsw28xmzHxyO9/Jtw3D5AWHxJ75SWIva/YrC7opNgxRFnlGIPacvoxtvnwG
	 xaxEesqPuyHtYk0CerQ/sPpoTe4uixrvVKVl6l61AevDF08O0CiqtI1jHlcB9LssNk
	 SmGK5VGqdAl9LV903/kVeKP7PVaPNHnrAtGXq9zEhl8PUbGycOe4emY9V4JnzCTHjr
	 H4LdzBBWmDVK7Wnhl43I5qCrs9ZE2jZiW5c/0Yd52QyfJhICh4Rtabdsbe28cm8/fj
	 zP6uvI8X2cUjQ==
Message-ID: <2943cf05-78a2-41dc-91b9-74cf959586b0@kernel.org>
Date: Tue, 11 Nov 2025 21:44:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware: stratix10-rsu: add COMPILE_TEST support
To: Rosen Penev <rosenp@gmail.com>, linux-kernel@vger.kernel.org
References: <20251110212400.282952-1-rosenp@gmail.com>
 <20251110212400.282952-3-rosenp@gmail.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20251110212400.282952-3-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rosen,

On 11/10/25 15:24, Rosen Penev wrote:
> Helps the buildbots catch potential issues.
> 
> Remove ARM64 dependency. ARM32 can build this now.
> 

This driver will not run on an ARM32, so why are we trying to build for it?

Dinh

