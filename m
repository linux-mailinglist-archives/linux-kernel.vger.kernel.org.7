Return-Path: <linux-kernel+bounces-876053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE02C1A858
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1231AA2050
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E50244671;
	Wed, 29 Oct 2025 12:46:47 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9A24167A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742007; cv=none; b=Lu4aI8QfwKy5CSzr2i76dwvFIPKKdCrimZpIClBK1fbv2DzjHfS5nFb8ZPVLUmfElg/ioAKhdSlANQVxX213PkwqB9NFzCGdP8Yrl/ICUJKrKe1H5jeT7+tufSLM8LdrPe4zP6Z1VD6aM27rHcJJVhU5obDmnZcnCB1ivNyNYcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742007; c=relaxed/simple;
	bh=mX0VEP+m33khPrsoPa7cGhx9oNBQBad9AbYcdTJAOxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SF++Uig2837YXpcOTSxa7gzhX7APWjwYCEqqxeTIKSUY1Ix2Dr94VxN1/zXM5eJg2R+K14PAy3ZdSq+VjPi14j6ACduGcduZmHgnKfaRfxTUYmmlC4n1nKV8+X00KD3jXn37ZYzYz+gs3G5ubp6FW6KPyAw57RsneCapUt3k/34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id B0A42140705;
	Wed, 29 Oct 2025 12:46:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id CF3508000E;
	Wed, 29 Oct 2025 12:46:40 +0000 (UTC)
Date: Wed, 29 Oct 2025 08:47:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] scripts: add tracepoint-update to the list of ignores
 files
Message-ID: <20251029084720.7108a80a@gandalf.local.home>
In-Reply-To: <20251029120709.24669-1-brgl@bgdev.pl>
References: <20251029120709.24669-1-brgl@bgdev.pl>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: stuhb5kty8erdunz8wyc8zpc8rx7u9s8
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: CF3508000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18CQ336kDjfqazx9zeBvVkZPX0/htCm9sA=
X-HE-Tag: 1761742000-276823
X-HE-Meta: U2FsdGVkX1+sFj7l62B1Kq2JU7XvYohv977+WgtrKNkY311wlwvXw0XjxCVdiUONzkVcKKbU0z+AoGLNR6RokBJJTjJLoH1HxDxQ3x+nrIN88+yaHLuK7VyvJECms4+eD+s2WxBJz2ehuIzhIOaaNaKNzVBpT6z/FyXn9qh1HC2EM7iiynXgz4Lg3rOjYpVfNwLRniH1azWyda1yz4EmJyf76PmHgyaztuDE7t7SG/jWEtAfh8Hj8L3IYXtiStX84VrxUrqZvtb5huJuUevzEj4vJJA5QpoZChbGfOSgVwcl7Sfk2vVRsNib+TcVlnd1BDZ5MGH5gf/4yLdh9yPB18nwCBmuXnD3Aeoge0rUG8QMINQEj65ErW+6FE5ZmauOXuOEVipI/LfLVJ4sF1JTzn3ZAbR5XBhCqtwwp/K3+ez1W7UZVP3mMc4cNnYDIYBl

On Wed, 29 Oct 2025 13:07:09 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The new program for removing unused tracepoints is not ignored as it
> should. Add it to the local .gitignore.
> 
> Fixes: e30f8e61e251 ("tracing: Add a tracepoint verification check at build time")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Applied, thanks!

-- Steve

> ---
>  scripts/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/.gitignore b/scripts/.gitignore
> index c2ef68848da5..4215c2208f7e 100644
> --- a/scripts/.gitignore
> +++ b/scripts/.gitignore
> @@ -11,4 +11,5 @@
>  /sign-file
>  /sorttable
>  /target.json
> +/tracepoint-update
>  /unifdef


