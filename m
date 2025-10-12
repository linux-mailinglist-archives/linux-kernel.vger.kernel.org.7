Return-Path: <linux-kernel+bounces-849568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5CFBD068E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 17:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE943BF8F0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 15:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86352EC0AB;
	Sun, 12 Oct 2025 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfuzvcU2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC136749C;
	Sun, 12 Oct 2025 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760284464; cv=none; b=Gam+P0hwhw3gt3hseNCI11xyXfZ/3nycJDXheg7qDb934alAsr4IfjL9akfK6mEqTlGFFGsgH+ENn6ODglJSXMHzXdEmkjl1x9X+4SjipWXpYQ6ibS0P6kgsFRfEKnYHISmdtQlApHrd+g0pRDhOgykkQ1FENZ3i1pgb3ATzw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760284464; c=relaxed/simple;
	bh=JPKi0+kjvmLZ1xwh/DBimtOHLkBByFXchq5IM6u4MRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3YwoZ3EUv9r5kJYthM9GkDKbftqQQlDbhdyxEMU8fDIBkXU7w/ChAXyMz6MfB+oGPKzakaQv/90Ln5tun59OiVOQLWH+GAwVGLkxOdvK+k0OkEwIIMMICfdaTxIRGze3ynMKk93ILY/zIGiCarKGCX0+mNRz1g8K6VqRgxUgPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfuzvcU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B243FC4CEE7;
	Sun, 12 Oct 2025 15:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760284463;
	bh=JPKi0+kjvmLZ1xwh/DBimtOHLkBByFXchq5IM6u4MRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nfuzvcU2cHUk0TvmLgvmstV6uX29xgY04qNcQMV520xf2qKdZ4H8P4XkvJfIfZxz+
	 xUpUn437Aq2840g9Fh5Gytdfttrn665HNo/XenTRQQjmI/+0Q56/DzQQxH2tSn9pZ/
	 oD76jmyFxenuV0uf6FCFQUt/gokIAUD3x+wyOFwFWlXgduoxi8VOCCQhLExdzB+IYE
	 hZ8z9PevrVSTVUc8hWw1StCBFp657hgXckOsNpUon+uh8Exe8GCbzuGWPiV9i2Sxsa
	 KO+jv0mCQCmuk/D4J+1zYQfiYIc2g6vfKyZ/42YzQ2JW49ePKSwnIHPuqEBUUZebmh
	 uBddkR2f765ig==
Date: Sun, 12 Oct 2025 16:54:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: dan@dlrobertson.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] iio: accel: bma400: Replace bit shifts with
 FIELD_PREP and FIELD_GET
Message-ID: <20251012165415.18d6154b@jic23-huawei>
In-Reply-To: <20251007055511.108984-5-akshayaj.lkd@gmail.com>
References: <20251007055511.108984-1-akshayaj.lkd@gmail.com>
	<20251007055511.108984-5-akshayaj.lkd@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Oct 2025 11:25:04 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> set_* functions involve left shift of param values into respective
> register fields before writing to register. Similarly get_* functions
> involve right shift to extract values from the respective bit fields.
> Replace these explicit shifting statements with standard kernel style
> macros FIELD_GET and FIELD_PREP.

Trivial but FIELD_GET() and FIELD_PREP() in patch descriptions (And title).
That helps show they take parameters and are function like.

> 
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
Code looks good to me

Jonathan

