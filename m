Return-Path: <linux-kernel+bounces-795168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D82F6B3EDBD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7A57A9A64
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F9D321F26;
	Mon,  1 Sep 2025 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlBycC+S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6AF16132A;
	Mon,  1 Sep 2025 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756750739; cv=none; b=HrUFUSKepEMYHMcSJ6fd652ZvKJH9nU3z3SHTgJMN7MzJGUYUKWGI1WSYqrjsGSd9LihKczYoHZ/nAccmZxlS3+wyq8H+3TYOgfUmsh8XUh/7t9PnR8NLbzu24GquuGJEi7k8Jj+dyWTcFtbTaDBhJhHewjYm48VCNM9uM+7LNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756750739; c=relaxed/simple;
	bh=7Kyem5o9tIBlzVjy/g3/1kJ1+KdaWx70IttLfM13BpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eSLB7L7X7GihRe40Z2pzSr+a3OSkgXQAT1E0xI2WxtrTec0HIa4on3O2g3TqDZGFIH9+xRBla93+wJZa9wXc5dF5J0OlKQC3hVrSctw6DQq8Vm0SLcHgInrmif7k+zzQV59DKJEM1pPXcgK0ZeJvoWvYZezHx6603O38G4gDHxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlBycC+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0C1C4CEF0;
	Mon,  1 Sep 2025 18:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756750739;
	bh=7Kyem5o9tIBlzVjy/g3/1kJ1+KdaWx70IttLfM13BpY=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To:From;
	b=HlBycC+So6+cM9GuGJM3utYXneTkdyZWFuGnA8tqMu0U2IuFSrw71pzswc4Q6X/JK
	 +djgze8HrXcLgjjERAtBNNh8nXjhxaZcib1VNrkA1ojP2GyeSnhFwbOKluI11onhtK
	 xI91YYLJcMRUdnm9cilUvZ+areYBEx3v/7WdVZpLnOM2ZgL1s6sCuXo9cdvWp743FG
	 IJeuI4GynioLF+V5xAjrXbx5+wBLE99SPqtsbSzkijey7woERdA0KCbbWZy1pmgQql
	 aTVD3X48jpNmyIMMqIWHtJF69yrqX1wDOEtl81Oo1K0BO5FKDz3mND1RQj1JBp+UKf
	 zyhmNm8Ixe6gQ==
Message-ID: <156fa755-6937-4df1-b995-99a2cc4bbb0a@kernel.org>
Date: Mon, 1 Sep 2025 20:18:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH v3 1/4] module: signing: Use pr_err for signature
 rejection
To: Jinchao Wang <wangjinchao600@gmail.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250829084927.156676-1-wangjinchao600@gmail.com>
 <20250829084927.156676-2-wangjinchao600@gmail.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250829084927.156676-2-wangjinchao600@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/08/2025 10.49, Jinchao Wang wrote:
> Make module signature rejection messages more visible by using pr_err
> instead of pr_notice.

Can you elaborate a bit more? Why is this needed?

IMO, I don't think making it more visible is enough rational to increase the
level.

