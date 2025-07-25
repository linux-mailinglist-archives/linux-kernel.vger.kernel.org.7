Return-Path: <linux-kernel+bounces-745463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D97B11A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9581C5A0168
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9903624DCEC;
	Fri, 25 Jul 2025 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="TZiyWJ17"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA5239E64
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433760; cv=none; b=bvg3jNHTd90owrWdhSyM89XUTGRMTMEGUfsVRsA2odKD+qwvPbaIWcypjINbrROlnh1+6FVUP1aZM6e+4+kXoDxmu19ctGK428JvW2SiSdF+XaZ79AJbp6F6ZnRMNZMsUV00UtjJp41EIVYV6Bk26DwPF5nsAFpoa85JKeCR4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433760; c=relaxed/simple;
	bh=JuuHd3/JWJkWh66N+Da1iNzdDmWdmTZCjsHYbDE9L68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZiSRfiBggOhmjYn+JWPy8eYCmrab56xwFlgnqNoasAneEcIzpR8RksamfEh+zbkNoQzaHZW+2riWRe+iz3zq+BaEsQ8lDlUVTZqKoRrA/Z2vOcmlChJVhDeiIE/zkeLkOkz6tr3i4UUFKTI9U80Bqavi4C5GQyjq4vPZ+RCD6Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=TZiyWJ17; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae360b6249fso315990866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1753433757; x=1754038557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LeP8D1ee7qumndKzatfF7n5JacNT1J8VdXDhVO9bUU=;
        b=TZiyWJ17XFqxg00XS6PN1aalVO00Fgdh5v11SNZvC56YP7pinWhR0w4Uz+9WbmmHoL
         vbBtWsQpak2+JkgdfpwpnTT6NICsUWNY9nD1LmgbU//B96OZbvYvsL4pbt8Q1cfFdgBJ
         PUpBGZ+rvLjUZxAiEAJeAjNzHPTt20MUamPesDjSax7bYI+TlN74d9hmOFosuGnixuEF
         81dKX5uHO633S0VLG6pFHvAyFs2e0DB5Ajc+1AgSqk5fHZxk8sqGAlqKYDgCnEmi1LUt
         xBN/SPbf8RX0v1LBqjF0gIZnkZiho/8xaiZd8hUSi60QRSqA6OkacUuvXauywfPLlZ2t
         Pv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753433757; x=1754038557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LeP8D1ee7qumndKzatfF7n5JacNT1J8VdXDhVO9bUU=;
        b=JAU/bG2TBsDvL1Cf47eBnz8uUPX6zAx0+yG2OTM9+xe29Jl45ipJ3ZH/MsBeoMGTVi
         VJ4Gk+YPXqK+uEWxMWJbmnoHhBKZ94bHkiMfkXUjPRc364GjigXVnl8wa6j34SunPBEY
         Sxero1oPUAdCG4hAIClian+pFZsJlZuNs+0iLCW79mXuelomcjoU9AGSC+yJcR4dVnLr
         qtkTUt3qihAB0avoL95qdDk1IOT+NayB2YIypMiCJ+UOQ3syeyZnj10Xx58tuTNtfK07
         J1TOjw2qraEceZi1qG/s6yQC6c0UALaPhgcgYdGr5lz9YhFmeYNVdjMPgNqyjTkKL6qU
         Pfow==
X-Forwarded-Encrypted: i=1; AJvYcCXPCNAKCZUGEuT+OZw96oYHBQL6EQO0vVIW1rTkk1cIGLORSZE4R8d0XduhEfija1DWLnCF84jUwvvW8Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo9l0FOGBx2z8Hga9sLY1SrBUc8QX51HGex79fPLnouZY1F9OC
	m8Aoqz5/FaLFmtvwNUo0iu5K08pPZYIZTMW+fujVBVPJlUBWzhKPe0AeGfoegKKYPb4=
X-Gm-Gg: ASbGncsxN5PJdFICb1sthxfXG9kMpP/gW6D5RJa85wR2gBSLZG19bJag9w8Zn9LMQot
	90JtbPD+O9aqPaU4pgll+5cfPhiictz3hgbjCQGxj0vmiddDotwHJGg4Q37Sz4Fs5AJpKTissNS
	csLRGu8DzOHnl/6jhGmJCpmyZxLjBFMM9epAuqbHh0SDT2B+vGM/JCRKwbre/Howl0eNKEYUM0e
	fzh7A30/vfdSJiZvAgAIhdjACQ5nEZDCngcD5YrXukUqKINcfEfZuyU2+U8+k5sXBAwNYYgkH2n
	LodmOSwt/0D0A/Rwqa/bDigVF53I/4H6+iOnv/XsBSezbLrSJD4JO4nIguIie90vOfoG9aanCFw
	pyTqDwrxc58Cmv2vopTaiXpGXODUD2g9LhVzr/Bm0umzzVPpXFQK6vIVdDMLSNHxQ
X-Google-Smtp-Source: AGHT+IESbgTMAbbOOQ4dkuWrJjDXut0veR7I0Y4h2kmNN5sqbg78IY81j+SvSd3mO/Y8gY1M5e4CZw==
X-Received: by 2002:a17:906:794b:b0:ae6:c555:8dcf with SMTP id a640c23a62f3a-af61cf980afmr167109166b.26.1753433756789;
        Fri, 25 Jul 2025 01:55:56 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47c496250sm240609066b.13.2025.07.25.01.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 01:55:56 -0700 (PDT)
Message-ID: <a1f88a9d-14b8-4547-a6c1-b880633775a5@blackwall.org>
Date: Fri, 25 Jul 2025 11:55:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] bonding: add support for per-port LACP actor
 priority
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
 Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Alessandro Zanni <alessandro.zanni87@gmail.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250724081632.12921-1-liuhangbin@gmail.com>
 <20250724081632.12921-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250724081632.12921-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/25 11:16, Hangbin Liu wrote:
> Introduce a new option ad_actor_port_prio, allowing users to set the actor
> port priority on a per-port basis in LACPDU.
> 
> This priority can be used in future enhancements to influence aggregator
> selection via ad_select policy.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  Documentation/networking/bonding.rst |  9 +++++++
>  drivers/net/bonding/bond_3ad.c       |  2 ++
>  drivers/net/bonding/bond_netlink.c   | 16 +++++++++++++
>  drivers/net/bonding/bond_options.c   | 35 ++++++++++++++++++++++++++++
>  include/net/bond_3ad.h               |  1 +
>  include/net/bond_options.h           |  1 +
>  include/uapi/linux/if_link.h         |  1 +
>  7 files changed, 65 insertions(+)
> 
> diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
> index a4c1291d2561..5e105e7ac8e6 100644
> --- a/Documentation/networking/bonding.rst
> +++ b/Documentation/networking/bonding.rst
> @@ -193,6 +193,15 @@ ad_actor_sys_prio
>  	This parameter has effect only in 802.3ad mode and is available through
>  	SysFs interface.
>  
> +ad_actor_port_prio
> +
> +	In an AD system, this specifies the port priority. The allowed range
> +	is 1 - 65535. If the value is not specified, it takes 255 as the


Leaving this as a note: it is set to 255 because actor_port_priorty is initialized to 255
                        and port_priority is initialized to actor_port_priority at slave
                        bind time.

> +	default value.
> +
> +	This parameter has effect only in 802.3ad mode and is available through
> +	netlink interface.
> +
>  ad_actor_system
>  
>  	In an AD system, this specifies the mac-address for the actor in
> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> index c6807e473ab7..4a1b2f01fe37 100644
> --- a/drivers/net/bonding/bond_3ad.c
> +++ b/drivers/net/bonding/bond_3ad.c
> @@ -436,6 +436,7 @@ static void __ad_actor_update_port(struct port *port)
>  
>  	port->actor_system = BOND_AD_INFO(bond).system.sys_mac_addr;
>  	port->actor_system_priority = BOND_AD_INFO(bond).system.sys_priority;
> +	port->actor_port_priority = SLAVE_AD_INFO(port->slave)->port_priority;
>  }
>  
>  /* Conversions */
> @@ -2197,6 +2198,7 @@ void bond_3ad_bind_slave(struct slave *slave)
>  		port->actor_admin_port_key = bond->params.ad_user_port_key << 6;
>  		ad_update_actor_keys(port, false);
>  		/* actor system is the bond's system */
> +		SLAVE_AD_INFO(slave)->port_priority = port->actor_port_priority;
>  		__ad_actor_update_port(port);
>  		/* tx timer(to verify that no more than MAX_TX_IN_SECOND
>  		 * lacpdu's are sent in one second)
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index ac5e402c34bc..ad91b93cbdac 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -28,6 +28,7 @@ static size_t bond_get_slave_size(const struct net_device *bond_dev,
>  		nla_total_size(sizeof(u8)) +	/* IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE */
>  		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE */
>  		nla_total_size(sizeof(s32)) +	/* IFLA_BOND_SLAVE_PRIO */
> +		nla_total_size(sizeof(u16)) +	/* IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO */
>  		0;
>  }
>  
> @@ -77,6 +78,10 @@ static int bond_fill_slave_info(struct sk_buff *skb,
>  					ad_port->partner_oper.port_state))
>  				goto nla_put_failure;
>  		}
> +
> +		if (nla_put_u16(skb, IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO,
> +				SLAVE_AD_INFO(slave)->port_priority))
> +			goto nla_put_failure;
>  	}
>  
>  	return 0;
> @@ -129,6 +134,7 @@ static const struct nla_policy bond_policy[IFLA_BOND_MAX + 1] = {
>  static const struct nla_policy bond_slave_policy[IFLA_BOND_SLAVE_MAX + 1] = {
>  	[IFLA_BOND_SLAVE_QUEUE_ID]	= { .type = NLA_U16 },
>  	[IFLA_BOND_SLAVE_PRIO]		= { .type = NLA_S32 },
> +	[IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO]	= { .type = NLA_U16 },
>  };
>  
>  static int bond_validate(struct nlattr *tb[], struct nlattr *data[],
> @@ -179,6 +185,16 @@ static int bond_slave_changelink(struct net_device *bond_dev,
>  			return err;
>  	}
>  
> +	if (data[IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO]) {
> +		u16 ad_prio = nla_get_u16(data[IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO]);
> +
> +		bond_opt_slave_initval(&newval, &slave_dev, ad_prio);
> +		err = __bond_opt_set(bond, BOND_OPT_AD_ACTOR_PORT_PRIO, &newval,
> +				     data[IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO], extack);
> +		if (err)
> +			return err;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index 91893c29b899..2b8606b4e4f5 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -79,6 +79,8 @@ static int bond_option_tlb_dynamic_lb_set(struct bonding *bond,
>  				  const struct bond_opt_value *newval);
>  static int bond_option_ad_actor_sys_prio_set(struct bonding *bond,
>  					     const struct bond_opt_value *newval);
> +static int bond_option_ad_actor_port_prio_set(struct bonding *bond,
> +					      const struct bond_opt_value *newval);
>  static int bond_option_ad_actor_system_set(struct bonding *bond,
>  					   const struct bond_opt_value *newval);
>  static int bond_option_ad_user_port_key_set(struct bonding *bond,
> @@ -221,6 +223,12 @@ static const struct bond_opt_value bond_ad_actor_sys_prio_tbl[] = {
>  	{ NULL,      -1,    0},
>  };
>  
> +static const struct bond_opt_value bond_ad_actor_port_prio_tbl[] = {
> +	{ "minval",  1,     BOND_VALFLAG_MIN},
> +	{ "maxval",  65535, BOND_VALFLAG_MAX},


You can add one more value: { "default", 255, BOND_VALFLAG_DEFAULT }


> +	{ NULL,      -1,    0},
> +};
> +
>  static const struct bond_opt_value bond_ad_user_port_key_tbl[] = {
>  	{ "minval",  0,     BOND_VALFLAG_MIN | BOND_VALFLAG_DEFAULT},
>  	{ "maxval",  1023,  BOND_VALFLAG_MAX},
> @@ -476,6 +484,13 @@ static const struct bond_option bond_opts[BOND_OPT_LAST] = {
>  		.values = bond_ad_actor_sys_prio_tbl,
>  		.set = bond_option_ad_actor_sys_prio_set,
>  	},
> +	[BOND_OPT_AD_ACTOR_PORT_PRIO] = {
> +		.id = BOND_OPT_AD_ACTOR_PORT_PRIO,
> +		.name = "ad_actor_port_prio",
> +		.unsuppmodes = BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
> +		.values = bond_ad_actor_port_prio_tbl,
> +		.set = bond_option_ad_actor_port_prio_set,
> +	},
>  	[BOND_OPT_AD_ACTOR_SYSTEM] = {
>  		.id = BOND_OPT_AD_ACTOR_SYSTEM,
>  		.name = "ad_actor_system",
> @@ -1793,6 +1808,26 @@ static int bond_option_ad_actor_sys_prio_set(struct bonding *bond,
>  	return 0;
>  }
>  
> +static int bond_option_ad_actor_port_prio_set(struct bonding *bond,
> +					      const struct bond_opt_value *newval)
> +{
> +	struct slave *slave;
> +
> +	slave = bond_slave_get_rtnl(newval->slave_dev);
> +	if (!slave) {
> +		netdev_dbg(bond->dev, "%s called on NULL slave\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	netdev_dbg(newval->slave_dev, "Setting ad_actor_port_prio to %llu\n",
> +		   newval->value);
> +
> +	SLAVE_AD_INFO(slave)->port_priority = newval->value;
> +	bond_3ad_update_ad_actor_settings(bond);
> +
> +	return 0;
> +}
> +
>  static int bond_option_ad_actor_system_set(struct bonding *bond,
>  					   const struct bond_opt_value *newval)
>  {
> diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
> index 2053cd8e788a..bf551ca70359 100644
> --- a/include/net/bond_3ad.h
> +++ b/include/net/bond_3ad.h
> @@ -274,6 +274,7 @@ struct ad_slave_info {
>  	struct port port;		/* 802.3ad port structure */
>  	struct bond_3ad_stats stats;
>  	u16 id;
> +	u16 port_priority;
>  };
>  
>  static inline const char *bond_3ad_churn_desc(churn_state_t state)
> diff --git a/include/net/bond_options.h b/include/net/bond_options.h
> index 18687ccf0638..4aee1935e0e7 100644
> --- a/include/net/bond_options.h
> +++ b/include/net/bond_options.h
> @@ -77,6 +77,7 @@ enum {
>  	BOND_OPT_NS_TARGETS,
>  	BOND_OPT_PRIO,
>  	BOND_OPT_COUPLED_CONTROL,
> +	BOND_OPT_AD_ACTOR_PORT_PRIO,
>  	BOND_OPT_LAST
>  };
>  
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 3ad2d5d98034..79bcbbc264a7 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -1562,6 +1562,7 @@ enum {
>  	IFLA_BOND_SLAVE_AD_ACTOR_OPER_PORT_STATE,
>  	IFLA_BOND_SLAVE_AD_PARTNER_OPER_PORT_STATE,
>  	IFLA_BOND_SLAVE_PRIO,
> +	IFLA_BOND_SLAVE_AD_ACTOR_PORT_PRIO,
>  	__IFLA_BOND_SLAVE_MAX,
>  };
>  


