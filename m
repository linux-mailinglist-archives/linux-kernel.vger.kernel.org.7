Return-Path: <linux-kernel+bounces-604826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DC4A8995B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 12:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B763B918B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 10:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053A81C6FF6;
	Tue, 15 Apr 2025 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MpnBc7dR"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113F2676CF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711504; cv=none; b=UwZHk/12Gi+t1qeK5bjvwOBx7OwRUlg1AYIS38R8K1+kMX6uvs0/QUHs8TtxwCUQZt1/aOC2SF3gG+h+gPPqTRVY7cXBYrJRx5RQXtmw4eRXVWusBoOE9ou+Nf9Lpo/LwrhIDuBLlBuTdt9jBK1Bsw9zA2q9MMllMUfHpr4Ngmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711504; c=relaxed/simple;
	bh=bTC9R3ofgpXdUIhmIm/lZbutlJ+tPH28aBzy5GAiXuA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NgYWRgY1nwza9Y9p71wGFceI7dhK7SobaSWhXLhmN9drtRwI4l3xJK88Qde3+4CUl8A8szwO7yhjJH/sAftoZPhxM21WwgyEjD0WaRYF5sagYRl66xk2DJp3Ni89NoS9OorePjPTAeSATnEMV6e5AaWkT+XgUGg+LD/FC0sf/7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MpnBc7dR; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2DB2943AED;
	Tue, 15 Apr 2025 10:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744711500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pqfNmGm6mpE9gcU7XWCSScG6BHeEmtIJ6Pq3PRYB6+Q=;
	b=MpnBc7dRkgmR8n8EwLeFa4sH9d6cr8e7f4q9ji60Xw3zKXWDRJrnpl3nQnlg0TRi/HqJaV
	zoLprT6uPxpRNnGMUWr+1l08qBPTrnOaJyF6AMyuVTG1ku/70e9U3dNjSEG3GBFmoQN2aG
	gVIRk2siIGys1/7gf/E7xc5gWrT3HePMegOVCvMEhg3uOtOQwotou4zr7yyB/dO0uGELBr
	GIKGtIlZT5IW9ja3t1NoPUKDA65ubh2sU3dFYNdx8TQGwfSBqccynefAg1NHEig+P5Nghx
	erRyUhnBrZd8xDsRvifradYx5lGjVF9kgoqj0mVAIw0S4zpjbHp0CUDX5f8Wlg==
Message-ID: <d97fa4de-ee0c-4bee-9cf2-cd3a343e3439@bootlin.com>
Date: Tue, 15 Apr 2025 12:04:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v3 23/54] dyndbg: treat comma as a token separator
To: Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
 gregkh@linuxfoundation.org, ukaszb@chromium.org, linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com
References: <20250402174156.1246171-1-jim.cromie@gmail.com>
 <20250402174156.1246171-24-jim.cromie@gmail.com>
Content-Language: en-US
Autocrypt: addr=louis.chauvet@bootlin.com; keydata=
 xsFNBGCG5KEBEAD1yQ5C7eS4rxD0Wj7JRYZ07UhWTbBpbSjHjYJQWx/qupQdzzxe6sdrxYSY
 5K81kIWbtQX91pD/wH5UapRF4kwMXTAqof8+m3XfYcEDVG31Kf8QkJTG/gLBi1UfJgGBahbY
 hjP40kuUR/mr7M7bKoBP9Uh0uaEM+DuKl6bSXMSrJ6fOtEPOtnfBY0xVPmqIKfLFEkjh800v
 jD1fdwWKtAIXf+cQtC9QWvcdzAmQIwmyFBmbg+ccqao1OIXTgu+qMAHfgKDjYctESvo+Szmb
 DFBZudPbyTAlf2mVKpoHKMGy3ndPZ19RboKUP0wjrF+Snif6zRFisHK7D/mqpgUftoV4HjEH
 bQO9bTJZXIoPJMSb+Lyds0m83/LYfjcWP8w889bNyD4Lzzzu+hWIu/OObJeGEQqY01etOLMh
 deuSuCG9tFr0DY6l37d4VK4dqq4Snmm87IRCb3AHAEMJ5SsO8WmRYF8ReLIk0tJJPrALv8DD
 lnLnwadBJ9H8djZMj24+GC6MJjN8dDNWctpBXgGZKuCM7Ggaex+RLHP/+14Vl+lSLdFiUb3U
 ljBXuc9v5/9+D8fWlH03q+NCa1dVgUtsP2lpolOV3EE85q1HdMyt5K91oB0hLNFdTFYwn1bW
 WJ2FaRhiC1yV4kn/z8g7fAp57VyIb6lQfS1Wwuj5/53XYjdipQARAQABzSlMb3VpcyBDaGF1
 dmV0IDxsb3Vpcy5jaGF1dmV0QGJvb3RsaW4uY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBItxBK6aJy1mk/Un8uwYg/VeC0ClBQJmlnw+BQkH8MsdAAoJEOwY
 g/VeC0ClyhwP/Ra6H+5F2NEW6/IMVHeXmhuly8CcZ3kyoKeGNowghIcTBo59dFh0atGCvr+y
 K9YD5Pyg9aX4Ropw1R1RVIMrWoUNZUKebRTu6iNHkE6tmURJaKLzR+9la+789jznQvbV+9gM
 YTBppX4/0cWY58jiDiDV4aJ77JDo7aWNK4hz8mZsB+Y7ezMuS4jy2r4b7dZ+YL/T9/k3/emO
 PkAuFkVhkNhytMEyOBsT7SjL4IUBeYWvOw9MIaXEl4qW/5HLGtMuNhS94NsviDXZquoOHOby
 2uuRAI0bLz1qcsnY90yyPlDJ0pMuJHbi0DBzPTIYkyuwoyplfWxnUPp1wfsjiy/B6mRKTbdE
 a/K6jNzdVC1LLjTD4EjwnCE8IZBRWH1NVC1suOkw3Sr1FYcHFSYqNDrrzO+RKtR1JMrIe8/3
 Xhe2/UNUhppsK3SaFaIsu98mVQY3bA/Xn9wYcuAAzRzhEHgrbp8LPzYdi6Qtlqpt4HcPV3Ya
 H9BkCacgyLHcdeQbBXaup9JbF5oqbdtwev3waAmNfhWhrQeqQ0tkrpJ46l9slEGEdao5Dcct
 QDRjmJz7Gx/rKJngQrbboOQz+rhiHPoJc/n75lgOqtHRePNEf9xmtteHYpiAXh/YNooXJvdA
 tgR1jAsCsxuXZnW2DpVClm1WSHNfLSWona8cTkcoSTeYCrnXzsFNBGCG6KUBEADZhvm9TZ25
 JZa7wbKMOpvSH36K8wl74FhuVuv7ykeFPKH2oC7zmP1oqs1IF1UXQQzNkCHsBpIZq+TSE74a
 mG4sEhZP0irrG/w3JQ9Vbxds7PzlQzDarJ1WJvS2KZ4AVnwc/ucirNuxinAuAmmNBUNF8w6o
 Y97sdgFuIZUP6h972Tby5bu7wmy1hWL3+2QV+LEKmRpr0D9jDtJrKfm25sLwoHIojdQtGv2g
 JbQ9Oh9+k3QG9Kh6tiQoOrzgJ9pNjamYsnti9M2XHhlX489eXq/E6bWOBRa0UmD0tuQKNgK1
 n8EDmFPW3L0vEnytAl4QyZEzPhO30GEcgtNkaJVQwiXtn4FMw4R5ncqXVvzR7rnEuXwyO9RF
 tjqhwxsfRlORo6vMKqvDxFfgIkVnlc2KBa563qDNARB6caG6kRaLVcy0pGVlCiHLjl6ygP+G
 GCNfoh/PADQz7gaobN2WZzXbsVS5LDb9w/TqskSRhkgXpxt6k2rqNgdfeyomlkQnruvkIIjs
 Sk2X68nwHJlCjze3IgSngS2Gc0NC/DDoUBMblP6a2LJwuF/nvaW+QzPquy5KjKUO2UqIO9y+
 movZqE777uayqmMeIy4cd/gg/yTBBcGvWVm0Dh7dE6G6WXJUhWIUtXCzxKMmkvSmZy+gt1rN
 OyCd65HgUXPBf+hioCzGVFSoqQARAQABwsOyBBgBCAAmAhsuFiEEi3EErponLWaT9Sfy7BiD
 9V4LQKUFAmaWfGYFCQfwx0ECQAkQ7BiD9V4LQKXBdCAEGQEIAB0WIQRPj7g/vng8MQxQWQQg
 rS7GWxAs4gUCYIbopQAKCRAgrS7GWxAs4gfGEACcA0XVNesbVIyvs5SJpJy+6csrH4yy233o
 GclX2P7pcCls55wiV6ywCtRaXWFjztYmklQieaZ/zq+pUuUDtBZo95rUP20E56gYV2XFB18W
 YeekTwH5d2d/j++60iHExWTB+sgMEv3CEGikUBj7iaMX2KtaB1k9K+3K6dx/s1KWxOClFkbJ
 EV/tmeq7Ta8LiytQM9b4yY550tzC0pEEeFcLFXo1m5KcJauYnAqrlOVY48NFpFUd9oAZf/Pz
 p3oEs+zn/8zK2PBrZZCD6AhrbotRy7irE5eimhxcsFm1+MG5ufnaQUWHrRYXVuFhvkSoqZ8j
 GPgPEpFor4NjRyX/PMLglQ7S5snkvKcr3Lun44aybXEHq/1FTzW2kOh6kFHFFOPbMv1voJKM
 IzrmDoDS+xANt/La7OwpCylCgF6t9oHHTTGfAfwtfYZbiepC66FDe/Jt/QLwkIXeIoeSS1O4
 6rJdGWG2kHthUM+uIbUbaRJW8AkJpzP1Mz7TieR/9jO4YPeUm9tGL5kP2yyNtzFilcoOeox1
 NSFNAPz+zPcovVmxAaSDGcSzhQVJVlk8xPib8g4fnI8qJ3Gj7xyw8D9dzxhCR2DIFmZL84En
 N7Rj+k4VIGY7M/cVvxL81jlbMGMERMmb96Cua9z1ROviGA1He2gbHOcp6qmLNu3nprleG8PL
 ZRNdEAC0iZapoyiXlVCKLFIwUPnxUz5iarqIfQU8sa1VXYYd/AAAFI6Wv3zfNtGicjgHP8rN
 CIegqm2Av1939XXGZJVI9f3hEoUn04rvxCgcDcUvn7I0WTZ4JB9G5qAGvQLXeXK6Byu77qTx
 eC7PUIIEKN3X47e8xTSj2reVTlanDr8yeqZhxpKHaS0laF8RbD85geZtAK67qEByX2KC9DUo
 eHBFuXpYMzGQnf2SG105ePI2f4h5iAfbTW9VWH989fx4f2hVlDwTe08/NhPdwq/Houov9f/+
 uPpYEMlHCNwE8GRV7aEjd/dvu87PQPm4zFtC3jgQaUKCbYYlHmYYRlrLQenX3QSorrQNPbfz
 uQkNLDVcjgD2fxBpemT7EhHYBz+ugsfbtdsH+4jVCo5WLb/HxE6o5zvSIkXknWh1DhFj/qe9
 Zb9PGmfp8T8Ty+c/hjE5x6SrkRCX8qPXIvfSWLlb8M0lpcpFK+tB+kZlu5I3ycQDNLTk3qmf
 PdjUMWb5Ld21PSyCrtGc/hTKwxMoHsOZPy6UB8YJ5omZdsavcjKMrDpybguOfxUmGYs2H3MJ
 ghIUQMMOe0267uQcmMNDPRueGWTLXcuyz0Tpe62Whekc3gNMl0JrNz6Gty8OBb/ETijfSHPE
 qGHYuyAZJo9A/IazHuJ+4n+gm4kQl1WLfxoRMzYHCA==
In-Reply-To: <20250402174156.1246171-24-jim.cromie@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfhuffvvehfjggtgfesthekredttddvjeenucfhrhhomhepnfhouhhishcuvehhrghuvhgvthcuoehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeetfffhtdeigfehffduuedvkeefgfdvuddugfffteetffdvteffgfejvedugffgffenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddvtdgnpdhmrghilhhfrhhomheplhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepjhhimhdrtghrohhmihgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgsrghrohhnsegrkhgrmhgrihdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehukhgrshiisgestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtoheplhhin
 hhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegrmhguqdhgfhigsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepihhnthgvlhdqghhvthdquggvvheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrgh
X-GND-Sasl: louis.chauvet@bootlin.com



Le 02/04/2025 à 19:41, Jim Cromie a écrit :
> Treat comma as a token terminator, just like a space.  This allows a
> user to avoid quoting hassles when spaces are otherwise needed:
> 
>   :#> modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p
> 
> or as a boot arg:
> 
>   drm.dyndbg=class,DRM_UT_CORE,+p  # todo: support multi-query here
> 
> Given the many ways a boot-line +args can be assembled and then passed
> in/down/around shell based tools, this may allow side-stepping all
> sorts of quoting hassles thru those layers.
> 
> existing query format:
> 
>   modprobe test_dynamic_debug dyndbg="class D2_CORE +p"
> 
> new format:
> 
>   modprobe test_dynamic_debug dyndbg=class,D2_CORE,+p
> 
> ALSO
> 
> selftests-dyndbg: add comma_terminator_tests
> 
> New fn validates parsing and effect of queries using combinations of
> commas and spaces to delimit the tokens.
> 
> It manipulates pr-debugs in builtin module/params, so might have deps
> I havent foreseen on odd configurations.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
> Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
> ---
> - skip comma tests if no builtins
> -v3 squash in tests and doc
> ---
>   .../admin-guide/dynamic-debug-howto.rst       |  9 +++++---
>   lib/dynamic_debug.c                           | 17 +++++++++++----
>   .../dynamic_debug/dyndbg_selftest.sh          | 21 ++++++++++++++++++-
>   3 files changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index 63a511f2337b..e2dbb5d9b314 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -78,11 +78,12 @@ Command Language Reference
>   ==========================
>   
>   At the basic lexical level, a command is a sequence of words separated
> -by spaces or tabs.  So these are all equivalent::
> +by spaces, tabs, or commas.  So these are all equivalent::
>   
>     :#> ddcmd file svcsock.c line 1603 +p
>     :#> ddcmd "file svcsock.c line 1603 +p"
>     :#> ddcmd '  file   svcsock.c     line  1603 +p  '
> +  :#> ddcmd file,svcsock.c,line,1603,+p
>   
>   Command submissions are bounded by a write() system call.
>   Multiple commands can be written together, separated by ``;`` or ``\n``::
> @@ -167,9 +168,11 @@ module
>       The given string is compared against the module name
>       of each callsite.  The module name is the string as
>       seen in ``lsmod``, i.e. without the directory or the ``.ko``
> -    suffix and with ``-`` changed to ``_``.  Examples::
> +    suffix and with ``-`` changed to ``_``.
>   
> -	module sunrpc
> +    Examples::
> +
> +	module,sunrpc	# with ',' as token separator
>   	module nfsd
>   	module drm*	# both drm, drm_kms_helper
>   
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 0d603caadef8..5737f1b4eba8 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -299,6 +299,14 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
>   	return nfound;
>   }
>   
> +static char *skip_spaces_and_commas(const char *str)
> +{
> +	str = skip_spaces(str);
> +	while (*str == ',')
> +		str = skip_spaces(++str);
> +	return (char *)str;
> +}
> +
>   /*
>    * Split the buffer `buf' into space-separated words.
>    * Handles simple " and ' quoting, i.e. without nested,
> @@ -312,8 +320,8 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
>   	while (*buf) {
>   		char *end;
>   
> -		/* Skip leading whitespace */
> -		buf = skip_spaces(buf);
> +		/* Skip leading whitespace and comma */
> +		buf = skip_spaces_and_commas(buf);
>   		if (!*buf)
>   			break;	/* oh, it was trailing whitespace */
>   		if (*buf == '#')
> @@ -329,7 +337,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
>   				return -EINVAL;	/* unclosed quote */
>   			}
>   		} else {
> -			for (end = buf; *end && !isspace(*end); end++)
> +			for (end = buf; *end && !isspace(*end) && *end != ','; end++)
>   				;

Why don't you use the skip_spaces_and_commas here?

>   			if (end == buf) {
>   				pr_err("parse err after word:%d=%s\n", nwords,
> @@ -601,7 +609,8 @@ static int ddebug_exec_queries(char *query, const char *modname)
>   		if (split)
>   			*split++ = '\0';
>   
> -		query = skip_spaces(query);
> +		query = skip_spaces_and_commas(query);
> +
>   		if (!query || !*query || *query == '#')
>   			continue;
>   
> diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> index 465fad3f392c..c7bf521f36ee 100755
> --- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> +++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
> @@ -216,7 +216,7 @@ function check_err_msg() {
>   function basic_tests {
>       echo -e "${GREEN}# BASIC_TESTS ${NC}"
>       if [ $LACK_DD_BUILTIN -eq 1 ]; then
> -	echo "SKIP"
> +	echo "SKIP - test requires params, which is a builtin module"
>   	return
>       fi
>       ddcmd =_ # zero everything
> @@ -238,8 +238,27 @@ EOF
>       ddcmd =_
>   }
>   
> +function comma_terminator_tests {
> +    echo -e "${GREEN}# COMMA_TERMINATOR_TESTS ${NC}"
> +    if [ $LACK_DD_BUILTIN -eq 1 ]; then
> +	echo "SKIP - test requires params, which is a builtin module"
> +	return
> +    fi
> +    # try combos of spaces & commas
> +    check_match_ct '\[params\]' 4 -r
> +    ddcmd module,params,=_		# commas as spaces
> +    ddcmd module,params,+mpf		# turn on module's pr-debugs
> +    check_match_ct =pmf 4
> +    ddcmd ,module ,, ,  params, -p
> +    check_match_ct =mf 4
> +    ddcmd " , module ,,, ,  params, -m"	#
> +    check_match_ct =f 4
> +    ddcmd =_
> +}
> +
>   tests_list=(
>       basic_tests
> +    comma_terminator_tests
>   )
>   
>   # Run tests

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



