Return-Path: <linux-kernel+bounces-770258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87219B27901
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC95600EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D090221270;
	Fri, 15 Aug 2025 06:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1QdwCBm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A2320D4E9;
	Fri, 15 Aug 2025 06:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238794; cv=none; b=E/HNEeEHBc1io/xM3C7mgpXl+JDixgyFaR9dAcOl8RrfDENH/7j+DjNn44hulfeioqLXCk6YBliWtt90OLdEW+wYnVK91ryn5/za028NY/Z5Na50S6kPhnPZc1y8OK9KfrIevQhvHRl18+f5xGpNtEEjpYHKhxb25POK1krLlj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238794; c=relaxed/simple;
	bh=Kd33Q43Fb7EMCUItpbr+1kxwivJPtHKJ8LEnS7S7o2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLt6YLpMQUQz4eH77aODdix1Lm6ZcDjdjOXkywHWBYRvsQjxaUJ34JOO2hZdkZpOiqDvB4JVTzXQ4Sd2crgyoXrS4EaQTa0rsE51/7RQNd6SNv0loLHUbQcKjN5Zt2/ZqDVPkSYSer5Om+YGjErb2htoxZOTjnmjdy7iOK6hkiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1QdwCBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABBEC4CEEB;
	Fri, 15 Aug 2025 06:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755238793;
	bh=Kd33Q43Fb7EMCUItpbr+1kxwivJPtHKJ8LEnS7S7o2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G1QdwCBmlZrbCZsGTNzLRa5jrGZMVfjjLMpjttPtu6pNIw3kN0oxzNs6qGpuqJmke
	 xfk7tdFqpz/44D5ZrXWbZTHFFhOZ4a5Gqu/zEoMYDzF1/qY9xOUKEebdUiFPn6ItJv
	 Kj2+zT+ca4gRdrzWi65GOgh8hjTJ0jyJNon0/J+I5Gz3mDh6NN2R+zLimx5KWPJ+3L
	 7H2m1Sc5YeCcTFb4D42CehwgIHkEQpm26MUFb8ZfhZXTVAlwPVwbFfV+PtNBF9R2VQ
	 atrkQ5uop4o9fjnYaySuGTVTHQkD8TLQFJ7v4zo+nvTgHBoLziAAsDyTjfeO/rXT/k
	 eAnmhjPq+3V7Q==
Date: Thu, 14 Aug 2025 23:19:53 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, workflows@vger.kernel.org
Subject: Re: [PATCH v2 1/2] README: restructure with role-based documentation
 and guidelines
Message-ID: <202508142316.C82AAE47@keescook>
References: <20250809234008.1540324-1-sashal@kernel.org>
 <20250809234008.1540324-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809234008.1540324-2-sashal@kernel.org>

On Sat, Aug 09, 2025 at 07:40:07PM -0400, Sasha Levin wrote:
> Reorganize README to provide targeted documentation paths for different
> user roles including developers, researchers, security experts,
> maintainers, and AI coding assistants. Add quick start section and
> essential docs links.

This looks really great; thank you for writing it all out!

> +* Attribution: Agents MUST add Assisted-by tag:
> +  Assisted-by: $AGENT_NAME-$AGENT_MODEL-$AGENT_VERSION $TOOL1 $TOOL2 ...
> +  Examples:
> +  - Assisted-by: Claude-claude-3-opus-20240229 checkpatch git-bisect
> +  - Assisted-by: GitHub-Copilot-GPT-4-v1.0.0 coccinelle sparse

I think "git" and "checkpatch" getting called out in Assisted-by is
overkill/redundant. Devs are going to use git constantly, and checkpatch
is already explicitly called out as a minimum standard linter for
submitting patches.

As for agent formatting, it's hard to parse "-" separators if they're
already used within the model/version. How about : or ; ?

--
Kees Cook

