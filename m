Return-Path: <linux-kernel+bounces-795270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAC7B3EF1F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404E01B221CE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2B4239E8A;
	Mon,  1 Sep 2025 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D3ai8ibo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E9E32F753;
	Mon,  1 Sep 2025 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756757020; cv=none; b=vAvilyI/aKfo6sS160zo6mKaOviIwvRxMT06zlqGVp+RUsDP95DgCkl1/QbO3JZd2nacU/OKfhVXZ/AMKU8m3Atv2y0W3PPeGv9svMpljDgzMep3DCgeNlUryHw5TLi6Ly0olOSjwOXdJtDxk8IZSXaE8FBDEJCdwO0pCkrBKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756757020; c=relaxed/simple;
	bh=ABBbzPW/6UgCX/sfTGVcUskFfJx+VpJZGLG1GYiZcWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ms5zytTpHUoTiKQC9LbLOl0OJk+N1Pl2/Ws+L8ieSdABNLje/R1PPrvPpwEEVkEIGjGNgiHbi9/Sst3qVNN6UryaKQXVtamDVqRWg2YvbD6FnNUaQYEZWogSodj/mpetF34SQ3++t6TDJx5Sm8SXCBZkpOI9QhLOzbV3Z9I5FhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D3ai8ibo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AA6C4CEF0;
	Mon,  1 Sep 2025 20:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756757019;
	bh=ABBbzPW/6UgCX/sfTGVcUskFfJx+VpJZGLG1GYiZcWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D3ai8iboGgoAXYygiCORD/fWBp/WDZ7yk+HF5r5FderXW/vUy6n8FT3LGOPyQ7umR
	 1UYmXp9hMxp/95BxTO/K8AeIdyGHuYl2fe1eXDJffNj8uO+uJdu2Th4/9H/7iYcOId
	 tPZrkSxXwNGTxuaHcLFz6FwRGDcmi5O8kzXv5eJ8=
Date: Mon, 1 Sep 2025 22:03:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gyujeong Jin <wlsrbwjd7232@gmail.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, gyutrange <wlsrbwjd643@naver.com>,
	stable@vger.kernel.org, DongHa Lee <gap-dev@example.com>,
	Daehyeon Ko <4ncient@example.com>, Geonha Lee <leegn4a@example.com>,
	Hyungyu Oh <dqpc_lover@example.com>,
	Jaewon Yang <r4mbb1@example.com>
Subject: Re: [PATCH] KVM: arm64: nested: Fix VA sign extension in VNCR/TLBI
 paths
Message-ID: <2025090123-worst-acid-92c8@gregkh>
References: <20250901141551.57981-1-wlsrbwjd7232@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901141551.57981-1-wlsrbwjd7232@gmail.com>

On Mon, Sep 01, 2025 at 11:15:51PM +0900, Gyujeong Jin wrote:
> From: gyutrange <wlsrbwjd643@naver.com>

Does not match your signed-off-by line :(


