Return-Path: <linux-kernel+bounces-845827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D172BC63C5
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FB4A4EF291
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FD02C08CE;
	Wed,  8 Oct 2025 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dx+dIQQz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0002C08BE
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759946613; cv=none; b=sEkNnKvpDoQiu8G415tyJJgSeGXezS88HKkGm1TPSrKWx/KTAS34jwKaddUIAAS26pQHy08V8RgShEK57d9bT5Gh95L3djv+FfC3LDzcX4ALDvDYZAmzEV3LpUxfdIUxk28G47U+Z5EBZOCEfA7ujM9nkVigivn4t0PDTSYNdoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759946613; c=relaxed/simple;
	bh=bk9IcjsHAjzeJKGBFPktoeUaQP11TRdKWiSa2+VXBlQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eYrib0EKAccVP6vhjnJmvWIdi2lXF3RheWPFK3NtTJu44095LWSDXI2Z2DJwAohZZh/0DsqJOE0BZgdqTXDi22uillYWNOPjhcLrIKHToS2PTq9c9fMpOBGrETTFfFYKIbaEG/SKaorw10As7xJaHqFuOnXrn0MhcI+vmcPDEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dx+dIQQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BEFC4CEE7;
	Wed,  8 Oct 2025 18:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759946612;
	bh=bk9IcjsHAjzeJKGBFPktoeUaQP11TRdKWiSa2+VXBlQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=dx+dIQQzzrPrjzc3YL4EPNcRyBiKa2njtZZ6BGwMFZQsLAGeHFOOMSRzuX+tAZQlA
	 nSkCy+SBJI7Bv0G16kLyo6RTkSWn1jX07CeMox1sy4G+genE1WW7TUoEUFD7f13dBS
	 BfAxs1KL9/ijVwN8RYg3K10xy4bYpZGqKC5T5kBkDCPw2h1NaqJsvhueO5+ByzabwM
	 RwoXq3lLAGScv8s78GPON4iwa5CjinDj3/uqtNdXENvU0LIUSPsxbnQKIe53iCEckW
	 /1x90dhBgwHiIVy/HdCsaq5xV0Jr5yhMYvx1/nGuXVg2mBKNtC2r2gk9UlmcNXrqOL
	 ZjirW+A0OWOUw==
Date: Wed, 8 Oct 2025 12:03:31 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Florian Schmaus <flo@geekplace.eu>
cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: entry: fix typo in comment 'instruciton' ->
 'instruction'
In-Reply-To: <20251006093742.53925-1-flo@geekplace.eu>
Message-ID: <66981f70-e036-c6a9-3ea0-90b3bcdd4be6@kernel.org>
References: <20251006093742.53925-1-flo@geekplace.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 6 Oct 2025, Florian Schmaus wrote:

> Signed-off-by: Florian Schmaus <flo@geekplace.eu>

Please don't forget to run checkpatch.pl on your patches before sending 
them; it would have caught the lack of a commit message.

I wrote a one-line patch description and queued it for 
early v6.18-rc; thanks.  


- Paul

