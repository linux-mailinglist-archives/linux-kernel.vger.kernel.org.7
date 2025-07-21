Return-Path: <linux-kernel+bounces-739626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64639B0C8B8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358A81C213C7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5912874E5;
	Mon, 21 Jul 2025 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9bt/BhT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F8D1FAC54;
	Mon, 21 Jul 2025 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115254; cv=none; b=ia8DVwyonJwbdzHM8zaxlK1WONeHU4Id5l38RbtUCDw2R2Y4k1+5bub/2wVDaF+vdoqVxnjs6766W2xwoCmuX910KaI4zo0z3VuQ1PD8wao/zVl1YCvbgR+OuP9bd+IxIRkUx8D88KS3nqdoiuXYCO5HsB2YhsNlF7G+PIiNMpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115254; c=relaxed/simple;
	bh=b0d+bnRoA9TIC8iQXqP3VrctHSad9OvpokIx7T7GPTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RbQZULa/wJd9tWCjqi0ntDoSm7cTTK6kkP9zqEqKoYAl4VoQOwuupLXKT/XrRpgqV+WdA/xooPLdjqWK7CkeZnhjEs8nAyrhaIbfj7LqqmAblCbDiSwRTG4T6CplStd2bq2OToPZgpajdPWiZoUCjFO/ybhVHBCjN6e834eNUX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9bt/BhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C450BC4CEF6;
	Mon, 21 Jul 2025 16:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753115253;
	bh=b0d+bnRoA9TIC8iQXqP3VrctHSad9OvpokIx7T7GPTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i9bt/BhTZN+41Lq9LCvFOIR5ZZSCs2DbpJXIwv61jUMIpd1GCfnlp5eHR/j97RDh9
	 bCrVRxkBRWseQIScsZjcqUL3MOwb/lo9b7Jvr6yZjiH6Q2VVb2466OKbq8svQUTX1Z
	 APRZcHtr6dzLWj1vsrDp3pBj6KuhMNqXzBPJ7NZC3w99nAGAaLOp/tt0RZ4DW2YhsW
	 PH/ptO/FOSDiAv6ZwKBXG9oi9OioH5xPBNXoMtcW2IU8YF2eZ2ap5mBB8IC3YIufMt
	 JcMKVRaJkrHIClEaKrICLFu9xqWcrBYBv5WwdjNPsyKP+PbveTo254P6EnIm79cgOD
	 p6iN2zwmVH3yA==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: update THP documentation to clarify sysfs "never" setting
Date: Mon, 21 Jul 2025 09:27:31 -0700
Message-Id: <20250721162731.9822-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721155530.75944-1-lorenzo.stoakes@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 21 Jul 2025 16:55:30 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Rather confusingly, setting all Transparent Huge Page sysfs settings to
> "never" does not in fact result in THP being globally disabled.
> 
> Rather, it results in khugepaged being disabled, but one can still obtain
> THP pages using madvise(..., MADV_COLLAPSE).
> 
> This is something that has remained poorly documented for some time, and it
> is likely the received wisdom of most users of THP that never does, in
> fact, mean never.
> 
> It is therefore important to highlight, very clearly, that this is not the
> ase.

case?

> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

