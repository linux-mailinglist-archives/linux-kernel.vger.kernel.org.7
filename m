Return-Path: <linux-kernel+bounces-709097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6604CAED93C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 12:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE95177637
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 10:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F01324DD10;
	Mon, 30 Jun 2025 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQU+lXA+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D3724501D;
	Mon, 30 Jun 2025 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751277762; cv=none; b=OG0ZcE40u55wQh+KtYkNyU3nf3eEU5xGqmHhXSmynPRb3THCn9qOGW2c69BF4MNZytVmihauQGn9XJCQvCwc8KLz/HrWeI3owBQ/qv5MzrjjXbLDHeQkPpzq1LdgA9OU3spE9xvQLnQ6rlSloUlhi6oT+U4SZXs4FHJ4NZtHu70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751277762; c=relaxed/simple;
	bh=jLH1LN0h4XQS5LpLuwgSjGSuH5trcdVyzXBOXiTXmfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj4U3kcBUcHrY6ymIP9SMKdOZ1ABvVcKxMZx6KIvaXys9j/z7Z8Sbie8emZB0k6qEP6qmb0cOJLSth67C8QlwR9hDn6AtsDMc8eol5w32hEuTyVkpD02RU/UErKTCQrWMBH9iQu4Df5RSbST3IbjhI1C3TrHKxiyKF3et15sZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQU+lXA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC997C4CEEB;
	Mon, 30 Jun 2025 10:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751277761;
	bh=jLH1LN0h4XQS5LpLuwgSjGSuH5trcdVyzXBOXiTXmfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQU+lXA+0cKxalyxZ5IaJPFo3izaFhFMDvl7V+FWjak0uXwb031tBumyfyIRIGIm+
	 IOXfMcE4s+k7fm2KhcwL1AzJv8PIUvYvvmuhVS/xd3gOvTHAC4nFF/m+SWzS+g8X5l
	 qwjCAQPA9ts9SI8O0QRputxVFxTHlg8+/Qhd1IzeFC97mPfCwN97KrHytecpZW8nf3
	 sC9vXvGof/K03oGTrayiooVDAP8PZ/sRmdYMmFChba23TNhDfCWKvBx+Pl/QfwD+df
	 3JIP8RiOxHGRon08sUIcOFJq3qpHcgyad3tdiJyCzsdDQtF2Mekynsp/Y263p0HqzF
	 /ghyU1BrBAQqQ==
Date: Mon, 30 Jun 2025 11:02:36 +0100
From: Simon Horman <horms@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v1 2/2] selftests: pp-bench: remove
 page_pool_put_page wrapper
Message-ID: <20250630100236.GB41770@horms.kernel.org>
References: <20250627200501.1712389-1-almasrymina@google.com>
 <20250627200501.1712389-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627200501.1712389-2-almasrymina@google.com>

On Fri, Jun 27, 2025 at 08:04:52PM +0000, Mina Almasry wrote:
> Minor cleanup: remove the pointless looking _ wrapper around
> page_pool_put_page, and just do the call directly.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


