Return-Path: <linux-kernel+bounces-723822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D48BEAFEB5C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F5618997A9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7CC2E6121;
	Wed,  9 Jul 2025 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h28Xfv+T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A272E5B2E;
	Wed,  9 Jul 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069716; cv=none; b=WGepje3mRIixd1LiGGVBVI+qgEVt9/pCfdE5x/wuS7vI9OvDSTFfM7JXETPali09OOWgA6U81smvBTpGlg2YmiXm95jd1uM4ubEULH+t+K83u6ldkt752sCaINUZh3pWzuFACJVdzF0KghKu1Q2xY8sW8eolp4+P+MdWKF30Qmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069716; c=relaxed/simple;
	bh=O3sM6IJo8yJB8JQhRCEpjnWcZn+zZ0AI1hBvV+VcGpw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=G1iC761Le9cJ9UkZwy63Unbo8/zjDtYy9MkdA9J/RuLJ6GYRXn+8sp/uM5PS4omfW+PiVz9oe5OSV5F2OzZXQNkiJRfMelFFH9iTQ2UBj5oFNglFbhkzzTTZ2nStChFHDj0P1JdIHySDJISmXdE7oZOfexJm5tA8eWFIcABcqtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h28Xfv+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B930C4CEEF;
	Wed,  9 Jul 2025 14:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069715;
	bh=O3sM6IJo8yJB8JQhRCEpjnWcZn+zZ0AI1hBvV+VcGpw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=h28Xfv+TNy943jokk3CjHoSCxY3XE3cGNrUwSWGySQmUktF41+N9xc4oLtKnTOLZx
	 ARGdroycI6g6HFlfb1gugaz4NoK+a1Njy07ZwN8/IYX+VHlTs5iw44usSOW98sQDIf
	 hPoDv+EX5lk3JZHX8M9dRk4LalJEFr+PsFd9/VsM/KUT7hI/LLKt5Tnp7pqWGRy7WP
	 1cdIuihlmsXuUjvoHP+bKX0Qk+UblIUr0nD7TXWttWgtNhLaYV0YrKBZbb7Ta5ncvy
	 CvWNPTM30UqBjKm6/PwXqScMu0FWppeZh+hvBPzNx/xgq3ERhnBWDKNyZKn2DHA8b1
	 wxDWX+1nsGkCg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 16:01:52 +0200
Message-Id: <DB7KVMH221GD.2K2PJ8SNRZA8L@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add mm folks as reviewers to rust alloc
Cc: "Vlastimil Babka" <vbabka@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, "Uladzislau Rezki" <urezki@gmail.com>,
 <rust-for-linux@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250708183747.104286-1-lorenzo.stoakes@oracle.com>
In-Reply-To: <20250708183747.104286-1-lorenzo.stoakes@oracle.com>

On Tue Jul 8, 2025 at 8:37 PM CEST, Lorenzo Stoakes wrote:
> The alloc implementation is a thin wrapper over slab/vmalloc, so to help
> out on the mm side of things and to be cc'd on changes, add some mm peopl=
e
> as reviewers.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Applied to alloc-next, thanks!

