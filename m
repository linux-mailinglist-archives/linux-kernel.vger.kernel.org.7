Return-Path: <linux-kernel+bounces-865493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DA1BFD6F6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36A63B75F8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F3934E746;
	Wed, 22 Oct 2025 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KytjhFJm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38F1275111;
	Wed, 22 Oct 2025 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149993; cv=none; b=MmH6AI103JZa9xbYu1Of9A8RkVGn1IPA/cRmTLW6YhLXwsDj3UAptcmZ59N1TsWynG+vWvQwSZ4TDNO3xz12nUDWYQUmvknBtW6B/AUo/GzvUIWmqPgrL63Em8uAvKlJVV1A2fax5Ww0uUaIxhLWZ5cOxYqDD5+3fejega4tNO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149993; c=relaxed/simple;
	bh=42fW/kZrr7BAeXGQ9pIcfCjCgAKlhltOQhbQ5NwKFZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6A9Ys6jeorANJOBAa/g5Ea+i8d8IJGcalRnsIgjjZMmXPryNo/2CdMVhkg1Zt7C12WDoKrR6pIxBJEptZ25IjKG8YFL/9HuvTN116Yv5fl0njqYdYmoQJ7xnkiOytjN3Aa+GCwHHZUDBGdg03tWn+84ku1npodhsSq+Ef0vJbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KytjhFJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D781C4CEFD;
	Wed, 22 Oct 2025 16:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149993;
	bh=42fW/kZrr7BAeXGQ9pIcfCjCgAKlhltOQhbQ5NwKFZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KytjhFJmz+NwT7vLnGoAUvA8UOgaeNvczUV0a5q2YXRYrM3qVU9349+jWh7PoJLQQ
	 9xaTG0FXqPhrKP4J6uKZroAA4IcjrjjP4pG87GMAInlv5PJ1nETouhvC6xHpICJMEM
	 DWHpp6QVCHu6VC70h3HHySkJIW/ffZLSX2NCUolNxcPUhiEKNAEk7UbtCa1LCc+V6L
	 gI4XSeg0ulfy5aN/cMEbgvSZiKy2KODjOQTA7T/FjXw5xhr1dmQ3VxFXZnp+noUFtx
	 5g0LOsM4HN8ICbo6c98clOJSTGF3mJWurY7oFZzr2z2YHXfHPtKBg0IqLsQAD88M9A
	 +e++hXwVorCQA==
Message-ID: <508ba490-9591-400a-a216-55a69b78c660@kernel.org>
Date: Wed, 22 Oct 2025 18:19:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] gpu: nova-core: various bitfield fixes
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Edwin Peer <epeer@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20251022-nova-bitfield-v1-0-73bc0988667b@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251022-nova-bitfield-v1-0-73bc0988667b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 12:50 PM, Alexandre Courbot wrote:
> These trivial patches fix a few issues reported by Edwin in [1].
> 
> [1] https://lore.kernel.org/rust-for-linux/F3853912-2C1C-4F9B-89B0-3168689F35B3@nvidia.com/
> 
> To: Danilo Krummrich <dakr@kernel.org>
> To: Alice Ryhl <aliceryhl@google.com>
> To: Edwin Peer <epeer@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Cc: Timur Tabi <ttabi@nvidia.com>
> Cc: nouveau@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: rust-for-linux@vger.kernel.org
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

