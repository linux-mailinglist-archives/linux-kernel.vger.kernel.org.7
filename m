Return-Path: <linux-kernel+bounces-887162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C7DC376DA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4883C3BD29A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9422320A3F;
	Wed,  5 Nov 2025 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LmfpU3sq"
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D342C08DA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369552; cv=none; b=K3kG9xIe6+jZurVbkD5W3q4edD+ItRHidDiyc7tPLZg/JnL2LG3Rhs6d08cl+KeDapHDHKBE8NtnBtKF3MjdWAeZAjsMJq7jwhl+KKikBNlbgWTCWuUS3vmHByKaGo+CTPw9rqpuueXZMd/ry4xgdroSLS062zBYeq55UBG6MqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369552; c=relaxed/simple;
	bh=7OySqMR3ksLRVRoYUVJId/JLhurW6nQXks0v1Zmnud8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txBnTWhP0F+Pcr2LL88YKos1jd+eOz4OGMmgw98iXMharpfOtQShBi6LQSx5WSNlzg3znzBeW9BYr2EAphKijAEJBdRQISGEaXHSfXRJf3NBwb0ictflpgQLBCE/FpVhviltqpQoyVlBZfZBsf8nF2OiO/bI9CeNEtK6/CSvv8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LmfpU3sq; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-431d65ad973so459865ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 11:05:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369550; x=1762974350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SbLzxA5t8CnJPSD/HZslr5jqHUjEIki1yyoivvHG0QI=;
        b=klyo1fHHtGyLNTQDA1pQqvYWhhE5Dq5PNCRQQOPFQBDMP6/Wq6/NoIXMi43Pj8w/fq
         BitDQaE1bMzjcJrLBalfVqQw8aB8wKzFsPLYWmjO3ApzNUQsG7yO3PTNwGkh6cHB6uV6
         MsgO9PtVX3Hqxs0Q1eGDVVG3STcVpH+f4yabLIddpLWKjdbImZvgm+zd853WA7Las3fF
         /IbsP0ZsjASuvhnDDhamqct6nsSL0hcBmeYTmPkADiHWRbzUB0OfMErk3qbGeJlGfWtd
         E4tXj7MGyUGvDaXEAEdiVYqFUAk45kvFvH5tNTqNqda7VzFCvqtMHd8e5DskOeRQxV9/
         wqFA==
X-Forwarded-Encrypted: i=1; AJvYcCW16xfrgn4ue/LHGYNsA9hltpfyy3OA+X/kerbOptG/bzVOWafPWKToJopqtNXnWkg3uZLcPvtQRA4yK7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHCXFDhuH6qJIWnzfoEJp8BiiwW5zHnPVASLfmQL51YfKSqD8h
	zTL3Gaw7EPvhL3MeXWpVZ44hfH7WqnBN/qt1nuaVl+SPcV9JcDAIeCF8nqm4EBtmejZdW894LY/
	zzyILPmzfvRWRjVM32kplRVut95Gp21YOY66kw5IUinU1UhZdt5JO4jAc6HA26m0ETBt/MzUrCk
	a50/K1OXIVtLOVKUL//HhO/1BVjFhyP9qyOZROydCsiVk6N409bgXVQIe5xvD+2q1u7kUY/f9Y8
	zCGwOm7EYTcGWE/5fk=
X-Gm-Gg: ASbGncsTQMY+UTnjsM69H9TmHtdjVsSrRwa/Ennj6Mx5IDDAvZOsOODB5Z+ySYRtorc
	pWr9nXnQJAHDL3MB16vn5FWmbVJocB9B/LeF6gYixbODTlQstXjGxFarf14Qbi91tMGY/QeTOs7
	2F6wH8Th8G+Scs2E5xnYuwT30g6kztldNkJhcPqa/g0JcLFmaYoWHTupFGSekck4D7ZP/mhs+5o
	1TCbt583mfe7VKNy9LWpUbSAsvLq4UDgjXf5paEnSDyDaEnVFlh2mv6FbO40ZPg/z1TbLozAhW/
	V6UnoBtrsY9toBlreq+3LvJI9n2M2kIKCr5bNt5zvym3kekh1P+8mEdTjy3cGy66k6HODBDlC3P
	BZj4YK4MO83djoBRRWyl963Lu1owdrXMbGpg30Cb/bSMSrKj7rNI/monbM6GmBhYCt2iChAUJJP
	bQ1ujwwsoZAPoFE+t5M8Sg7BgqonU70eW7fkju
X-Google-Smtp-Source: AGHT+IGLxy5lytbuiP8ipXvAuV3lcX38a0R1KRJvIoiXw/PZrhix3cd2bGIkRSs/JBZ4APtCqOegvRrUMSZ4
X-Received: by 2002:a05:6e02:3106:b0:433:2b83:33ed with SMTP id e9e14a558f8ab-433407af5f6mr60981495ab.9.1762369550244;
        Wed, 05 Nov 2025 11:05:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4334f44a507sm134255ab.2.2025.11.05.11.05.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Nov 2025 11:05:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6411e349b73so77753a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 11:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762369547; x=1762974347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SbLzxA5t8CnJPSD/HZslr5jqHUjEIki1yyoivvHG0QI=;
        b=LmfpU3sqB8bCBO28x8DjJqzG0x8iL0gV0opO4tk8e124ErRNr8FUpmW7eZvDy/PB03
         CgYFPfjVUY8EexXJM98bp0b/IG59PRHXbzS8OJr9rxH5JjsBJwlvrgB2eNcsBFKbYhZv
         f9giG9Zzq01VACmtU1jGjvwcOfCNHnMQQVBD4=
X-Forwarded-Encrypted: i=1; AJvYcCUZ1f04+CivJVzWLoduU/XM1kDkyPGt46KonaoarslGrop5ZmHgxiB3k1bjC18dJMRBleuCofDZ7sk7VDg=@vger.kernel.org
X-Received: by 2002:a05:6402:13cb:b0:640:7690:997e with SMTP id 4fb4d7f45d1cf-6410589b532mr4469834a12.3.1762369547558;
        Wed, 05 Nov 2025 11:05:47 -0800 (PST)
X-Received: by 2002:a05:6402:13cb:b0:640:7690:997e with SMTP id
 4fb4d7f45d1cf-6410589b532mr4469810a12.3.1762369547179; Wed, 05 Nov 2025
 11:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-grxrings_v1-v1-1-54c2caafa1fd@debian.org>
In-Reply-To: <20251105-grxrings_v1-v1-1-54c2caafa1fd@debian.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Wed, 5 Nov 2025 11:05:34 -0800
X-Gm-Features: AWmQ_bl5sAu4acxptbQQWQKxza7hK026iidWM-ZCPTg7etQbj3JqVyEA4gUc-mc
Message-ID: <CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com>
Subject: Re: [PATCH net-next] tg3: extract GRXRINGS from .get_rxnfc
To: Breno Leitao <leitao@debian.org>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ddcb610642dda29b"

--000000000000ddcb610642dda29b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 10:02=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
> optimize RX ring queries") added specific support for GRXRINGS callback,
> simplifying .get_rxnfc.
>
> Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
> .get_rx_ring_count().
>
> Given that tg3_get_rxnfc() only handles ETHTOOL_GRXRINGS, then this
> function becomes useless now, and it is removed.
>
> This also fixes the behavior for devices without MSIX support.
> Previously, the function would return -EOPNOTSUPP, but now it correctly
> returns 1.
>
> The functionality remains the same: return the current queue count
> if the device is running, otherwise return the minimum of online
> CPUs and TG3_RSS_MAX_NUM_QS.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> PS: This was compiled-tested only and NOT tested on a real hardware.
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/b=
roadcom/tg3.c
> index d78cafdb20949..fa58c3ffceb06 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -12719,29 +12719,17 @@ static int tg3_get_sset_count(struct net_device=
 *dev, int sset)
>         }
>  }
>
> -static int tg3_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *i=
nfo,
> -                        u32 *rules __always_unused)
> +static u32 tg3_get_rx_ring_count(struct net_device *dev)
>  {
>         struct tg3 *tp =3D netdev_priv(dev);
>
>         if (!tg3_flag(tp, SUPPORT_MSIX))
> -               return -EOPNOTSUPP;
> +               return 1;
>
> -       switch (info->cmd) {
> -       case ETHTOOL_GRXRINGS:
> -               if (netif_running(tp->dev))
> -                       info->data =3D tp->rxq_cnt;
> -               else {
> -                       info->data =3D num_online_cpus();
> -                       if (info->data > TG3_RSS_MAX_NUM_QS)
> -                               info->data =3D TG3_RSS_MAX_NUM_QS;
> -               }
> +       if (netif_running(tp->dev))
> +               return tp->rxq_cnt;
>
> -               return 0;
> -
> -       default:
> -               return -EOPNOTSUPP;
> -       }
> +       return min(num_online_cpus(), TG3_RSS_MAX_NUM_QS);

The existing code to use num_online_cpus() is actually not correct.
This is more correct:

return min(netif_get_num_default_rss_queues(), tp->rxq_max);

I think when netif_get_num_default_rss_queues() was used to replace
num_online_cpus(), tg3_get_rxnfc() was not properly converted.

Thanks.

--000000000000ddcb610642dda29b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVWQYJKoZIhvcNAQcCoIIVSjCCFUYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLGMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGjzCCBHeg
AwIBAgIMZh03KTi4m/vsqWZxMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNDk1NloXDTI3MDYyMTEzNDk1NlowgdcxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzENMAsGA1UEBBMEQ2hhbjEQMA4GA1UEKhMHTWljaGFlbDEWMBQGA1UEChMNQlJPQURDT00g
SU5DLjEiMCAGA1UEAwwZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTEoMCYGCSqGSIb3DQEJARYZ
bWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AKkz4mIH6ZNbrDUlrqM0H0NE6zHUgmbgNWPEYa5BWtS4f4fvWkb+cmAlD+3OIpq0NlrhapVR2ENf
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCAq54X6
LbigKCMQcj9cwpsJfC5jvKkzzZTwsebkTdeIcTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNTExMDUxOTA1NDdaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBFlsrx+dB92/ImjyP1A47mzz9dFSt8SR+PzAsmK3PI
iZDPIKZ7hoiOiGPZKP6kXMgqmBrls96iNg2sk3oT+UhYLCFQROyq7NFNdD+Shas/jFiaVTYMs26B
aXATrN7F5f+SmDrXeA/v221C9JxDke+oKkDkhhGWsLaAlm0LL5TAYBVHbHemPu6ZyZCh4QZmNYeS
C7czTBI7s1RARi1fodWlL9on1Ehip2rsAu95z3RP6VfMVAvQ4YYBSrPByccP0GYPof5XIkUvgFqw
fW8JsMJ9Sj3i38SimMBU29nToOkA6lCr/KVg8obvIu2B3qVQ0sktWxoubbEtuxMMsuIBIv70
--000000000000ddcb610642dda29b--

