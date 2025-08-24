Return-Path: <linux-kernel+bounces-783476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6913FB32E1B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4236916BE52
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 08:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30424A05B;
	Sun, 24 Aug 2025 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRwkLqfJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934B2393DF4;
	Sun, 24 Aug 2025 08:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756022774; cv=none; b=YENEp4T2i7i0PKQIjuipAwOAtvj+q/d9zAOVrsyxofakY3ijLx7+tSeG2/CqJH2NZQlpLwFxLtG2cWlATa+EiCkxse7JhPGWUEz6FdKN8hWjCE9CF9Ha8Vtx3hvnq0Cs03SPcdrg46pewr6DsE5OkGUvZ7FsTIA9PEu67SL5bow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756022774; c=relaxed/simple;
	bh=8S+GPRDjk7EnBA+RTw3CmuYot4R9hUC+LoTBeX6HmIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KAKawlwfeErOXWNvdr2Zp4E8uuqkt/VL6vNltCrxh8oWRRRf+eZ6uJjEyJqY3y9n9Dj+DD2rWJSObsIMhTxT+gE9GuM6/6x4mDXst9Lo2TKUtfRwW1z9fbg28xNx3nWdWVxXHmesgksptEEzpkGX6O74CcyUnvcgdAwzxqLj3cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRwkLqfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8329EC4CEEB;
	Sun, 24 Aug 2025 08:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756022774;
	bh=8S+GPRDjk7EnBA+RTw3CmuYot4R9hUC+LoTBeX6HmIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LRwkLqfJagdqNY7h7FC0JsA0vv5Rtlch72Gtx2wJxp+msV2qyp5L4TB1TvCz2hJAA
	 rHlkxj8E6sxjvX79bgAZrVJMrosMylmW9T/mkEJadB9SyL9wL0DKf+R4DrYgatGLYC
	 WM+V1YbKKPCxkU2d3T4iDZxZZar+Fan4uPcbbjqkvmbZoVbvWBRwOnqCVH9Ysf+lGU
	 hu6NplavJiIvL1/Kq0yIQQtZzgBIOOni1TbRmpzEiiqq1OuFBEt8X87bmzW8jELKfE
	 7JfIAfWyCT1IkRJyb3LM/oH7XfwrPY8imj6VqzUfmZZSmRBNgTpEa/w/Z+CG9RiPB/
	 Ip2QxSLImcXCA==
From: William Breathitt Gray <wbg@kernel.org>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Breathitt Gray <wbg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH] counter: Alphabetize component_id sysfs attributes Documentation list
Date: Sun, 24 Aug 2025 17:06:06 +0900
Message-ID: <175602272524.419332.11019880243782691194.b4-ty@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250615-alphabetize-component_id-doc-v1-1-4c5943b41198@kernel.org>
References: <20250615-alphabetize-component_id-doc-v1-1-4c5943b41198@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=537; i=wbg@kernel.org; h=from:subject:message-id; bh=fjZggBxLpxlbfcLqwmB0ZuoYeOky8VtFt/hNWCK5/FE=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDBmrjl+ez5Dnf9+vlZ3beR5HXp3P6ucbZWYZsM/8zmY1t 5XRYrZxRykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjCRzckMf3jrZJ9Oy/bUsVK2 WeWQt7/o+7N3WezrH7Zsc3p3bKls7VJGhkvOpiLhOslszuFBQozSE/K7dff/TRc+v4n93maZh+v kmAE=
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Sun, 15 Jun 2025 23:27:47 +0900, William Breathitt Gray wrote:
> Prefer alphabetical order for the component_id sysfs attributes list in
> the Counter ABI Documentation file. This should make it easier for users
> to locate a component_id attribute in the list and its respective
> Documentation entry.
> 
> 

Applied, thanks!

[1/1] counter: Alphabetize component_id sysfs attributes Documentation list
      commit: 36ee9770a8b24c71805760cb160c25ef91192823

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

