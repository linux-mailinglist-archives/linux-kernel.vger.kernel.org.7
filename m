Return-Path: <linux-kernel+bounces-813935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49736B54D41
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5293BEEE8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FD6321F57;
	Fri, 12 Sep 2025 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/oSd1W4"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9D5301018
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678931; cv=none; b=JPMG2DgqoBK6wOvZ/y9NuJWfeqUzTC+z0DlE5vCz9Az0isP3tzQk/ogTHymKwxNu5vrWUkMKZd/5zfkReUEUf3THLjkssDpoqAuvqbRBpsZn/bLv9durCJTWQPELqCm9/DHQzmvwkiJp3Ou0VLM4m6miDe72DMutnGPefQEX8UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678931; c=relaxed/simple;
	bh=pg2OzxfdDmvV4PZ3/yrEF/ttLXM7KmEXR3GgYwf88oM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=fa6lrTMcNST2nhKswP37dlYXbu1oWfiilOoxq5zyORyO56nR//JihUlXJyo7jDU4BcxbckfnVxrD6bNAIvbDJM1fKrA0/3cWQC8oY/ywyB3pAi2Uzd+NcA/4DAzfRxP9DU4b4rgZFHRhlqCoQGx37rr+InPBp5+3uwHWmhK7Zi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/oSd1W4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45df09c7128so14938325e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757678928; x=1758283728; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3mBB6R4Rvgptsn0OxjqAYg70NanrEyHXxP0kqh9yyw=;
        b=j/oSd1W49q5GqUpc4lcLYvy2FpJ6r6ZYirBlz6SCqXtj+q1E4NhrYMAZRt2jCALf3Z
         aYdOqFTvZZ7W3ga1P0A4UJ4iPdackJG2xm3HJTeoqJnVJ3+xXSFFYLDYJ6rBlWxTyIvS
         u8CIOf11nkX+DDYBU9a4/FJ7TDYPDJTJ3d5Pjn4MOJcDzWSBjvjp/59HyOerZOkzWRrz
         P3Yl115aDgI4ZVtknoMN6rAtqJ9Uh9w+3qjzQK3X0WdDAvFPmDmhCLcS/QoXXqXtzi5q
         EgzhFN7HpA1/iV+GgMS10JQNKzIiXB64Iukc582CTVveKrg/kBbBhvImGFf9zN8MN/JP
         z0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678928; x=1758283728;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3mBB6R4Rvgptsn0OxjqAYg70NanrEyHXxP0kqh9yyw=;
        b=VvHMLxbpinZ8R9hG+vgreZ54DnkZczEsPLwsjJuMWhsDje28sTRrELUlUTV3kwGIF+
         r4NnxJ+D0KVhApY1iF3AheiB5JaXUrbECFcc2pAa682yWgaI/uzDPzElzLfgt9OPfJrL
         0BjeMXolctBt78++Ifi5b5/099MCqJge4OLUIR9BrgVzJ+dga8qB2PQC3Mfulu0H/fQq
         M7KPLtmcz2I8r5cS1vN8DY8xdVbFtW3namFYFrS5nEzucfRtotTDWkSyNfSs6kEBblhm
         yTXW/JYEY6JHY4ojp3kroGk4/DES9udUEOdPeZtkPgWI55fdXCf3PHv/s+aKK7Gyhvmx
         L+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCW8o2VmxxMVy8i3JNccuybtr3KyzUdHhi/207lz7FFCmBQDGbQQvc+d13Rui2S7JlG/RfUVi7TRdRYc8wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8WbD/Xv8tU3wTmDLjXS5qt/hNRkWJPfkiTNhp78CsNKpLBk67
	5EeZwPJvnfjP8n+2Gzgaxts86L3HS3nOyhaFmf58+jLdjMY/7XH2V9J+qGgg5A==
X-Gm-Gg: ASbGncv2AAo/J9OAYVbJrrZ7N7gAYLwwa2xzfUAHKwCY0uPJHLSSb6zRFKZs5qI0sVs
	tAGz5oGEgKyGLbN5rqFCW2e1rgm9sVZYDBR9oMei3CQ1EBkLnKSVcd+fh5MC45BPAR32GV2q4Ei
	UlmBmIGhRjHEF0gdpxLvy5qjNexhGFR4ylnnKCTdpc3ztqDsZlUJnDklThUmeOCUj6rhoQ4Pg/7
	T7N29ReClP9QOGbCwhKJyIsWA2Ov6GJQzsq6J7a2nlclCDtYEfv9tYVc0y7MwBuMNuVCjErx0bw
	VxR9DwXUAF7wTvPb9pfROENihKXvbBKdNONAeQi0EMVWrQTp863OOfg1phQBGW3pnGBSTpd3fEn
	Z8YC411BsfCogI1jvXAbOzmcaVXOPXNBZOA==
X-Google-Smtp-Source: AGHT+IGv/35p/W7r3GHx5SA997jhumk8Hh17nHWyXFsjPVhFKF0I3tiZFXsC/nBQd4qsEp3pwnV0nA==
X-Received: by 2002:a05:600c:548f:b0:45b:8ad2:76c8 with SMTP id 5b1f17b1804b1-45f2125d5cdmr28593575e9.2.1757678927561;
        Fri, 12 Sep 2025 05:08:47 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037186e5sm60557925e9.5.2025.09.12.05.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:08:47 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,  Jakub Kicinski <kuba@kernel.org>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  linux-doc@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tools: ynl: rst: display attribute-set doc
In-Reply-To: <a1f55940-7115-4650-835c-2f1138c5eaa4@kernel.org>
Date: Fri, 12 Sep 2025 12:07:04 +0100
Message-ID: <m2ecscudyf.fsf@gmail.com>
References: <20250910-net-next-ynl-attr-doc-rst-v1-1-0bbc77816174@kernel.org>
	<m2v7lpuv2w.fsf@gmail.com>
	<a1f55940-7115-4650-835c-2f1138c5eaa4@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthieu Baerts <matttbe@kernel.org> writes:

> Hi Donald,
>
> On 11/09/2025 12:44, Donald Hunter wrote:
>> "Matthieu Baerts (NGI0)" <matttbe@kernel.org> writes:
>> 
>>> Some attribute-set have a documentation (doc:), but it was not displayed
>>> in the RST / HTML version. Such field can be found in ethtool, netdev,
>>> tcp_metrics and team YAML files.
>>>
>>> Only the 'name' and 'attributes' fields from an 'attribute-set' section
>>> were parsed. Now the content of the 'doc' field, if available, is added
>>> as a new paragraph before listing each attribute. This is similar to
>>> what is done when parsing the 'operations'.
>> 
>> This fix looks good, but exposes the same issue with the team
>> attribute-set in team.yaml.
>
> Good catch! I forgot to check why the output was like that before
> sending this patch.
>
>> The following patch is sufficient to generate output that sphinx doesn't
>> mangle:
>> 
>> diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
>> index cf02d47d12a4..fae40835386c 100644
>> --- a/Documentation/netlink/specs/team.yaml
>> +++ b/Documentation/netlink/specs/team.yaml
>> @@ -25,7 +25,7 @@ definitions:
>>  attribute-sets:
>>    -
>>      name: team
>> -    doc:
>> +    doc: |
>>        The team nested layout of get/set msg looks like
>>            [TEAM_ATTR_LIST_OPTION]
>>                [TEAM_ATTR_ITEM_OPTION]
> Yes, that's enough to avoid the mangled output in .rst and .html files.
>
> Do you plan to send this patch, or do you prefer if I send it? As part
> of another series or do you prefer a v2?

Could you add it to a v2 please.

> Note that a few .yaml files have the doc definition starting at the next
> line, but without this '|' at the end. It looks strange to me to have
> the string defined at the next line like that. I was thinking about
> sending patches containing modifications created by the following
> command, but I see that this way of writing the string value is valid in
> YAML.
>
>   $ git grep -l "doc:$" -- Documentation/netlink/specs | \
>         xargs sed -i 's/doc:$/doc: |/g'
>
> Except the one with "team", the other ones don't have their output
> mangled. So such modifications are probably not needed for the other ones.

Yeah, those doc: entries look weird to me too. Not sure it's worth
fixing them up, given that they are valid. Also worth noting that the
two formats that we should encourage are

  doc: >-
    Multi line text that will get folded and
    stripped, i.e. internal newlines and trailing
    newlines will be removed.

  doc: |
    Multi line text that will be handled literally
    and clipped, i.e. internal newlines and trailing
    newline are preserved but additional trailing
    newlines get removed.

So if we were to fix up the doc:$ occurrences, then I'd suggest using
doc: >-

Cheers,
Donald

