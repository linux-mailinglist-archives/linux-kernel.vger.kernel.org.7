Return-Path: <linux-kernel+bounces-796680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C627B405DD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D47171842
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DFC31E107;
	Tue,  2 Sep 2025 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEf1MwSM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24642FAC19
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821083; cv=none; b=hiUDMSqpE4dyYJdnwiS113rOz3zQLn84KBTJdSB1ywT5ml1lo9r9JWwz1tdzFdjsWXbP+m3zSx4O3W1Dm+tyLW688QPgJ4tbQQPmrSd8I3z88cLsBSaHwJzISNYd2O+btOESzWi6WekMSPGZiJb6pauOPmrL7ZhDej8bdEpgEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821083; c=relaxed/simple;
	bh=fzLIkjf13oqOrd9WScq2CantRkcwIt9xJt+QxtYtrfk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=I2e2WiLThtdJIJ725F/ES7/dQAqTg05cIqLWdNWq8MhNW1NmosCmJ5Fs8OMVY5DkthSdYtfF+Wooti+tlB+z44A6EUN3UJYjDnnx70xVOT1bD3m7geQn79Bz8kC04jTTq20fCppP2djB4txPoJWp3ImaYVSt4ILa1SLjjwgrKbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEf1MwSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7FDC4CEED;
	Tue,  2 Sep 2025 13:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756821082;
	bh=fzLIkjf13oqOrd9WScq2CantRkcwIt9xJt+QxtYtrfk=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=qEf1MwSMuq+W4iJ3Bdq7vDcaBoQHSuFhKUn5fCh/9K6QmK07O67h6V4KdMqVQweXY
	 R/ZyKAuR2+0SxCMBZTpWlxtFVYgjVG6lqDtCEJTRds+u2d5Evdb8AS+HGGXdRYuw0+
	 SVqaLnDNosakssraywfALd6o7N1+e8vH+iaTAr0iZxgXoZVGx43/HmZcdTeKsRViM5
	 RxAiJIXsterIbbfO790pqPRwcxRw9hR+uEvRginoleGRyp4TyV0Fq3hqrSZdMqIzmM
	 T316KwEcn3nq/7WU53CO1goNUcN473iCa2TeYVLwkJ6yvn9WEy8M9RsbLrwjnjT/x1
	 E8kOxKTl0VWWw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Sep 2025 15:51:18 +0200
Message-Id: <DCID3HS7BBSY.244VUJMOWACV8@kernel.org>
To: "James Jones" <jajones@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update git entry for nouveau
Cc: "Lyude Paul" <lyude@redhat.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, "LKML" <linux-kernel@vger.kernel.org>
References: <20250826195716.1897-1-jajones@nvidia.com>
In-Reply-To: <20250826195716.1897-1-jajones@nvidia.com>

On Tue Aug 26, 2025 at 9:57 PM CEST, James Jones wrote:
> The gitlab repository previously associated with
> the nouveau module has fallen out of use. The
> drm-misc tree here:
>
> https://gitlab.freedesktop.org/drm/misc/kernel.git
>
> Is now where most nouveau-related patches are
> applied. This change updates the MAINTAINERS file
> to reflect this.
>
> Signed-off-by: James Jones <jajones@nvidia.com>

Applied to drm-misc-fixes, thanks!

