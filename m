Return-Path: <linux-kernel+bounces-858000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A5BBE884C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE29E1AA3C72
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A779E2E5B27;
	Fri, 17 Oct 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fqnk4XHt"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691BF2D77E6
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760702769; cv=none; b=oHwy53rVaMFuRRUBk4P1H0jqmmvIZtAjoZ/DhVGEFND0VbWI/nVP2yFQS/WLPIOBxsPHeZc7hIJxO+EN5eQhU4ZGx1LHsz2hPV0adctJ9KqNwcu5fBxZ2s838AxHLXK8+aLdanrPdu3oMfUHklrIm1sln3kFVZv05iXsK2eSesY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760702769; c=relaxed/simple;
	bh=+NgMevCRO6L5hXhJaaqAwueyAJujC7V7TL40Xm8q1k4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=s0LUuZqtQMR81QkD9w9DfspVPWKdfcd5sUy1RzksE6jLMLNmakLM55gnH/gnlBN71/0NJ9BNj3Ce04kPazjCuEL4fGAL8xQGt8IPL6+klfDxTUQsAxaHEO7sCcmIOZNsY1uVz4/9U1LWaXU/wfMpA2FlbhBcwSqZ4pvY9p962dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fqnk4XHt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47100eae3e5so18165775e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760702765; x=1761307565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nMJOXnoCYtJ81aWFXZNVAXjz4V/A/3LlOZhUuqnJKQw=;
        b=Fqnk4XHt0Jh8dbaATrWbwwB0fCERbcjPoxZy9iLPmC+nH9PLpP2XBinYA3vtAAfLHF
         taz05ifTkug5bXHCJwHPgBEtg/PfG7xcMRgUMKnQd6PAa9to+7jT2AzW1Cff1rAvXmmK
         W704HX0Pof3v/op/toy78Jrkxhdlu8toJ2DrHhJK4eOcbHgT/UfaU1HeTVJFYuPavPni
         1CEsIEl+ZM4hbkPrTTi2ejrFbVcgCHsB/0izQ20yDwbBL9t8KBRD7i5blgLfuoltF6uQ
         Il/XVjSk418McwOotZ4E+GhRZnVUJ1ewsYnNtLtL0LwXWxNpjev7u7k+nIkQ7u69Qcf8
         XnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760702765; x=1761307565;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMJOXnoCYtJ81aWFXZNVAXjz4V/A/3LlOZhUuqnJKQw=;
        b=WfKXYDcKYWjGZBN2O5oB1yGzOe9nlmjXIoLzd3bceHK5EZ0Ds+/QaGq+KZZv65Xjnv
         gJBDBXPBmbMvS+MFr/XdHXqQ+Znr1UxXKR1o3tni5Lb2KxW4H2MfRUgDaf92FxfYYXId
         CAFIxIN1Gut06IFhGOBCER/gp+AfWSzXuCpqGwDkKXc3SKPCY0eKY02JmGB1b8hs8SzB
         ro1pGq6as6/qrwJZPtWAeROwZnEwNUXeOvUrM69keVu3qnUF4xyZ2qAnCMR3Xk1sBgWP
         4/5elYY2lj9RyCNJSw1aN9LrpnTfY89TAzeFADrwTUNf52TnjsVgM8rIN+6ve65d80zL
         xNFg==
X-Forwarded-Encrypted: i=1; AJvYcCXneDMOxq9IefNjOqa1ASFoHfrusGFmDYPdfhbwKszNUyWgNgBH8poSwWjmGSmnMk5eJrhA6l8lmOsqaTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKNQRK2oDzy3ieoUVc1OE42EoEp03z0wGeZfNwhX5YkuyWfiZs
	zkkcts/dYgOv17OiukyNUuq8L7DY5AveAreaNdtlST4+itIzi9l4AJAD9eCSMhphxPI=
X-Gm-Gg: ASbGncsBdgvuYEyaGUu6VC9vkvi+ZqMinqaied4uqfu1SOeTzoS0YEiFECsOwqhMWB6
	+lHCBJW/GuyCgW7/C7dO8mMbr6fEdVJcG2GkEyVn2K71bxO/8KtIF1yxsC5lhrlCqf8qg5ZIAT2
	UVhtcm2aOce7xN2vb/o1uU/Z0S/qPGfGf/Az7x3qPLpqZyB8M/wmGpam9NKsQkdKFs/q1jgZ8/o
	OlQISnzjhfemlcRGATjzzHd5jUgKcQHvvgQRuSnRpbDQEQUtiY+2oi7ENbV/b29JoLqKiqFcErx
	cPQ2AtWAqtIx/cCXbqCb4m2lB2gVMzzlEawQdDdGLzQmvI2d9kRHqdT5RQvs1TPySPpjInh1oYe
	O0Fkq02IO0NtW+oQJ1V92pTq/wxx0NjJ4OdHAQOyLXtH4g68r77nx0vlmTvktZ+Ov7Os9OcR8/m
	CZaxidR6ltwfxa7K/urV8a
X-Google-Smtp-Source: AGHT+IFRqPYZeqMdMjuOp1opwrAil9k3VDnWPeVIrTRqMOXEXLvF1v38xSucSH6cagYDSWL467ybBA==
X-Received: by 2002:a05:600c:4eca:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-4711786c6f0mr28564785e9.7.1760702764657;
        Fri, 17 Oct 2025 05:06:04 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144239bdsm107319845e9.3.2025.10.17.05.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 05:06:04 -0700 (PDT)
Message-ID: <e0b031d6-2b2d-4788-ac9c-b76e6a4bfab0@suse.com>
Date: Fri, 17 Oct 2025 14:06:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] module: Simplify warning on positive returns from
 module_init()
To: Lucas De Marchi <lucas.demarchi@intel.com>
References: <20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com>
 <20251013-module-warn-ret-v1-2-ab65b41af01f@intel.com>
Content-Language: en-US
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251013-module-warn-ret-v1-2-ab65b41af01f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 6:26 PM, Lucas De Marchi wrote:
> It should now be rare to trigger this warning - it doesn't need to be so
> verbose. Make it follow the usual style in the module loading code.
> 
> For the same reason, drop the dump_stack().
> 
> Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr

