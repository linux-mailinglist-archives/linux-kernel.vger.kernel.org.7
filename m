Return-Path: <linux-kernel+bounces-884556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E3FC306FC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 317834E7C29
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8B4313E0C;
	Tue,  4 Nov 2025 10:12:38 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99417311971
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251158; cv=none; b=qb8jHAMF+SdWYKuDWO3FImXU1ia0sbqBrL9OG4xVzRYICwyapSb/eSj1eVEVlmzXZAlqbu9eDgF+3+mAYpo4M2GnBSGCJf59y7CLM8ehW5j4QtidFB5XLS8jAXq5Xxq2ATIUNo2PvTBlRidOdAn2xn0A5btmot83nMbw7Vel4NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251158; c=relaxed/simple;
	bh=PrK6pB5BJHP7W+BBYZEXkvRbs58hUfFJ0Y6ZF9KTrus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwRVVbH89bi/jtbbNk3yAUn0VwSMXdPeMr+vN4+vENmfMQcOiqk/hQZUzVw0DUnWB6y9thlo+VF704yRkqT9lF1VJgLzpCsDtl14R6xGRrohYbmnq9pzgftFSlaROiPAJ+ppm3EFatlsyL0zBogzLHJaJGKcyUnjOMT6lN7BQbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b710601e659so272645566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762251155; x=1762855955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNh9dqNPl/MWMN2lVTbAD5Fn1iEQRgYG4Mm2+Idpemg=;
        b=gJrPv8G1JtQ8JQ61zI0ErPIZSsa68UU21qnRbWAkq5+frSDomH3wVaL4eXnLS16BH/
         Pwx+HDJOp47J4CT0yUnaJSxICLFfC/QvbpDTFqm1iFJgGhnwwFOMiUL52NaSX0r3+4QB
         4T3kzdDMw0zz2xsKGSsM/DYe2N7NtVSIcFWMe7jnnadVpi+SfKt6XER291WmfN3FfoqY
         3RqzPtO2sTuhIESwwAyCPkvzny5G1rz2X5SIrG/7adZ/8gEpPlFLKZM+SKwrXPoz0x5h
         BxUzTtPmLa8CuilxQxhi5PJok8SxR08VRxwWeObEvZDjDFdNBO7VX7BPDEjp75KAtMo0
         5U9g==
X-Forwarded-Encrypted: i=1; AJvYcCXvwCnSY241bjucJEGT/k5beK9YrR8fDbjuPU9zUvZUs7e59vRvdp9Nc2o13BEOXEjvks37Nu0xi+UtHjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj+qYBi6FrBsjHVU6yAeMPdqfq+DHfVTdmdzzLxshB4VPwjonL
	5gH1KJIkqlKQ/s9X/qMbSlTWL+l1H1RTCZlQR9MWkgz8AyTDCx5w5Y+9+TiBbw==
X-Gm-Gg: ASbGncv/czWDm3rYVMMIAihmWrjk0fZ5wGeDQ6MC8NCKI01JpXb4UohqucSVZPgWhCl
	ldkPlrRWu8LbY4EagdPiiVtxpxtY6uEF1qdLi/h5lRXnhvt8dThhUnwRnt1YZ8Ne0NrC+HOm1E0
	OJhLD7LwUDI7fQW3UO3A2EgqOKT6vO02EJEV692I8TjYt0M7zZnl42ufJ18IC3Eymuvd/G8HoAK
	l3u7KkF+pbI52oPPqB+nhqMuoZmAXSgF9nPC/mZO65JZoIxCYMeOl1FHqHVq/gFoBu+b+lRKkLf
	rc4Ar0pGD+uASYAHtNRnvWUhK0rBee7s5R5DIUz++ghYlHdeMq4cBJeJVVKg1MMybATtJPZkkcN
	jamW7KqTZHKMti+JEsepuhC8q1A0kYQDf9bi0GybUhix9COp4DZRDK+H2Ly0JHZJW4IQ=
X-Google-Smtp-Source: AGHT+IGQIiLUL2jCplWGWCxon/2S5vXopmyY0ct5xQv5tkc3QvWJLRcXGwfVs2NKteJjsf3xyzDfbA==
X-Received: by 2002:a17:907:2d0e:b0:b71:5064:be0d with SMTP id a640c23a62f3a-b715064c16emr535111366b.41.1762251154719;
        Tue, 04 Nov 2025 02:12:34 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:49::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72406568a2sm170855966b.73.2025.11.04.02.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:12:34 -0800 (PST)
Date: Tue, 4 Nov 2025 02:12:32 -0800
From: Breno Leitao <leitao@debian.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: a.hindborg@kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] configfs: Constify ct_group_ops in struct
 config_item_type
Message-ID: <apftq3nt33ma7citvlrub772eysehqvtb2mbywqlfm56grhnhf@vvnix52rixzz>
References: <cover.1761390472.git.christophe.jaillet@wanadoo.fr>
 <6b720cf407e8a6d30f35beb72e031b2553d1ab7e.1761390472.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b720cf407e8a6d30f35beb72e031b2553d1ab7e.1761390472.git.christophe.jaillet@wanadoo.fr>

On Sat, Oct 25, 2025 at 01:15:37PM +0200, Christophe JAILLET wrote:
> Make 'ct_group_ops' const in struct config_item_type.
> This allows constification of many structures which hold some function
> pointers.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Breno Leitao <leitao@debian.org>

